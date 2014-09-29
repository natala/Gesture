//
//  NZAction+CoreData.m
//  Gesture
//
//  Created by Natalia Zarawska on 8/25/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZAction+CoreData.h"
#import "NSManagedObject+CoreData.h"

@implementation NZAction (CoreData)

#pragma mark - Create
+(NZAction *)create
{
    return (NZAction *)[super createEntityWithName:ENTITY_NAME_ACTION];
}

#pragma mark - Find
+ (NSArray *)findAll
{
    return [super findAllEntitiesWithName:ENTITY_NAME_ACTION];
}

+ (NSArray *)findAllSortedByName
{
    NSSortDescriptor *actionSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    return [[NZAction findAll] sortedArrayUsingDescriptors:@[actionSortDescriptor]];
}

+ (NZAction *)findLates
{
#warning incomplete implementation
    NSLog(@"NZUrlSession find lates to be implemented!!!");
    return nil;
}

+ (BOOL)existsWithName:(NSString *)name
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", name];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:ENTITY_NAME_ACTION];
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
    [super destroyAllEntitiesWithName:ENTITY_NAME_ACTION];
}


@end
