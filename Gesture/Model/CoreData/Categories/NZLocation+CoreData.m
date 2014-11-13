//
//  NZLocation+CoreData.m
//  Gesture
//
//  Created by Natalia Zarawska on 11/13/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZLocation+CoreData.h"
#import "NSManagedObject+CoreData.h"

NSString *const kGlobalLocationName = @"Global";

@implementation NZLocation (CoreData)

#pragma mark - Create
+(NZLocation *)create
{
    return (NZLocation *)[super createEntityWithName:ENTITY_NAME_LOCATION];
}

#pragma mark - Find
+ (NSArray *)findAll
{
    return [super findAllEntitiesWithName:ENTITY_NAME_LOCATION];
}

+ (NSArray *)findAllSortedByName
{
    NSSortDescriptor *locationSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    return [[NZLocation findAll] sortedArrayUsingDescriptors:@[locationSortDescriptor]];
}

+ (NZLocation *)globalLocation
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", kGlobalLocationName];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:ENTITY_NAME_LOCATION];
    request.predicate = predicate;
    NSError *error = nil;
    NSArray *foundEntities = [[NZCoreDataManager sharedManager].managedObjectContext executeFetchRequest:request error:&error];
    
    NZLocation *globalLocation;
    
    if (!foundEntities || [foundEntities count] == 0) {
        globalLocation = [NZLocation create];
        globalLocation.name = kGlobalLocationName;
    } else {
        globalLocation = [foundEntities objectAtIndex:0];
    }
    return globalLocation;
}

+ (BOOL)existsWithName:(NSString *)name
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", name];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:ENTITY_NAME_LOCATION];
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
    [super destroyAllEntitiesWithName:ENTITY_NAME_LOCATION];
}

@end
