//
//  NZSensorDataSet+CoreData.m
//  Gesture
//
//  Created by Natalia Zarawska on 7/1/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZClassLabel+CoreData.h"
#import "NSManagedObject+CoreData.h"

@implementation NZClassLabel (CoreData)

#pragma mark - Create
+(NZClassLabel *)create
{
    return (NZClassLabel *)[super createEntityWithName:ENTITY_NAME_CLASS_LABEL];
}

#pragma mark - Find

+ (NZClassLabel *)findEntitiesWithIndex:(NSNumber *)index
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"index == %@", index];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:ENTITY_NAME_CLASS_LABEL];
    request.predicate = predicate;
    NSError *error = nil;
    NSArray *foundEntities = [[NZCoreDataManager sharedManager].managedObjectContext executeFetchRequest:request error:&error];
    
    if (!foundEntities) {
        NSLog(@"couldn't find class label entity with index == %@", index);
        return nil;
    }
    if ([foundEntities count] > 1) {
        NSLog(@"WARNING - more than one entitie with index %@ found. Will return the first found one", index);
    }
    return (NZClassLabel *)foundEntities.firstObject;
}

+ (NSArray *)findAll
{
    return [super findAllEntitiesWithName:ENTITY_NAME_CLASS_LABEL];
}

+ (NZClassLabel *)findLates
{
    NSSortDescriptor *sortDescriptotr = [[NSSortDescriptor alloc] initWithKey:@"index" ascending:YES];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:ENTITY_NAME_CLASS_LABEL];
    
	fetchRequest.sortDescriptors = @[sortDescriptotr];
    
	NSError *error = nil;
	NSArray *fetchedEntities = [[NZCoreDataManager sharedManager].managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
	if (!fetchedEntities) {
		NSLog(@"Error: %@", error);
        abort();
	}
    
    return [fetchedEntities lastObject];
    
}

+ (BOOL)existsWithName:(NSString *)name
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", name];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:ENTITY_NAME_CLASS_LABEL];
    request.predicate = predicate;
    NSError *error = nil;
    NSArray *foundEntities = [[NZCoreDataManager sharedManager].managedObjectContext executeFetchRequest:request error:&error];
    
    if (!foundEntities) {
        NSLog(@"couldn't find class label entity with index == %@", name);
        return false;
    }
    return [foundEntities count] != 0;
}

#pragma mark - Destroy
- (void)destroy
{
    [super destroy];
}

+ (void)destroyAll
{
    [super destroyAllEntitiesWithName:ENTITY_NAME_CLASS_LABEL];
}

@end
