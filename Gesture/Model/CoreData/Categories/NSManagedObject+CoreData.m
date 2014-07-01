//
//  NSManagedObject+CoreData.m
//  KneeHapp
//
//  Created by Pascal Fritzen on 05.05.14.
//  Copyright (c) 2014 Praxis. All rights reserved.
//

#import "NSManagedObject+CoreData.h"

@implementation NSManagedObject (CoreData)

#pragma mark - Create

+ (NSManagedObject *)createEntityWithName:(NSString *)name
{
	return [NSEntityDescription insertNewObjectForEntityForName:name
										 inManagedObjectContext:[NZCoreDataManager sharedManager].managedObjectContext];
}

#pragma mark - Find

+ (NSArray *)findAllEntitiesWithName:(NSString *)name
{
	NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:name];

	fetchRequest.predicate = nil;
	fetchRequest.sortDescriptors = @[];

	NSError *error = nil;
	NSArray *fetchedEntities = [[NZCoreDataManager sharedManager].managedObjectContext executeFetchRequest:fetchRequest
																									 error:&error];

	if (!fetchedEntities) {
		NSLog(@"Error: %@", error);
	}

	return fetchedEntities;
}

#pragma mark - Destroy

+ (void)destroyAllEntitiesWithName:(NSString *)name
{
	for (NSManagedObject *entity in [self findAllEntitiesWithName : name]) {
		[entity destroy];
	}
}

- (void)destroy
{
	[self.managedObjectContext deleteObject:self];
}

#pragma mark - Cloning

- (NSManagedObject *)clone
{
	return [self cloneInContext:[NZCoreDataManager sharedManager].managedObjectContext withCopiedCache:[NSMutableDictionary dictionary] exludeEntities:@[]];
}

- (NSManagedObject *)cloneInContext:(NSManagedObjectContext *)context withCopiedCache:(NSMutableDictionary *)alreadyCopied exludeEntities:(NSArray *)namesOfEntitiesToExclude
{
	NSString *entityName = [[self entity] name];

	if ([namesOfEntitiesToExclude containsObject:entityName]) {
		return nil;
	}

	NSManagedObject *cloned = [alreadyCopied objectForKey:[self objectID]];
	if (cloned != nil) {
		return cloned;
	}

	// create new object in data store
	cloned = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:context];
	[alreadyCopied setObject:cloned forKey:[self objectID]];

	// loop through all attributes and assign then to the clone
	NSDictionary *attributes = [[NSEntityDescription entityForName:entityName inManagedObjectContext:context] attributesByName];

	for (NSString *attr in attributes) {
		[cloned setValue:[self valueForKey:attr] forKey:attr];
	}

	// Loop through all relationships, and clone them.
	NSDictionary *relationships = [[NSEntityDescription entityForName:entityName inManagedObjectContext:context] relationshipsByName];
	for (NSString *relName in [relationships allKeys]) {
		NSRelationshipDescription *rel = [relationships objectForKey:relName];

		NSString *keyName = rel.name;
		if ([rel isToMany]) {
			// get a set of all objects in the relationship
			NSMutableSet *sourceSet = [self mutableSetValueForKey:keyName];
			NSMutableSet *clonedSet = [cloned mutableSetValueForKey:keyName];
			NSEnumerator *e = [sourceSet objectEnumerator];
			NSManagedObject *relatedObject;
			while (relatedObject = [e nextObject]) {
				// Clone it, and add clone to set
				NSManagedObject *clonedRelatedObject = [relatedObject cloneInContext:context withCopiedCache:alreadyCopied exludeEntities:namesOfEntitiesToExclude];
				[clonedSet addObject:clonedRelatedObject];
			}
		} else {
			NSManagedObject *relatedObject = [self valueForKey:keyName];
			if (relatedObject != nil) {
				NSManagedObject *clonedRelatedObject = [relatedObject cloneInContext:context withCopiedCache:alreadyCopied exludeEntities:namesOfEntitiesToExclude];
				[cloned setValue:clonedRelatedObject forKey:keyName];
			}
		}
	}

	return cloned;
}

@end
