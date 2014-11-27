//
//  NZSingleAction+CoreData.m
//  Gesture
//
//  Created by Natalia Zarawska on 7/1/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZSingleAction+CoreData.h"
#import "NSManagedObject+CoreData.h"
#import "NZLocation+CoreData.h"
#import "NZClassLabel.h"
#import "NZGesture.h"

@implementation NZSingleAction (CoreData)

#pragma mark - Create
+(NZSingleAction *)create
{
    NZSingleAction *action = (NZSingleAction *)[super createEntityWithName:ENTITY_NAME_SINGLE_ACTION];
    action.location = [NZLocation globalLocation];
    return action;
}

#pragma mark - Find
+ (NSArray *)findAll
{
    return [super findAllEntitiesWithName:ENTITY_NAME_SINGLE_ACTION];
}

+ (NSArray *)findAllSortedByName
{
    NSSortDescriptor *actionSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    return [[NZSingleAction findAll] sortedArrayUsingDescriptors:@[actionSortDescriptor]];
}

+ (NSArray *)findAllSortedByNameActionsForLocation:(NSString *)locationName
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"location.name == %@", locationName];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:ENTITY_NAME_SINGLE_ACTION];
    request.predicate = predicate;
    NSError *error = nil;
    NSArray *foundEntities = [[NZCoreDataManager sharedManager].managedObjectContext executeFetchRequest:request error:&error];
    
    return foundEntities;
}

+ (NZSingleAction *)findActionForLocation:(NSString *)locationName andGesture:(NSString *)gestureName
{
    NSArray *actions = [NZSingleAction findAllSortedByNameActionsForLocation:locationName];
    if ([actions count] > 0) {
        for (NZSingleAction *action in actions) {
            for (NZGesture *gesture in action.gestureSingleReverse) {
                if ([gesture.label.name isEqualToString:gestureName]) {
                    return action;
                }
            }
        }
    }
    return nil;
}

+ (NZSingleAction *)findLates
{
#warning incomplete implementation
    NSLog(@"NZSingleAction find lates to be implemented!!!");
    return nil;
}

#pragma mark - Destroy
- (void)destroy
{
    [super destroy];
}

+ (void)destroyAll
{
    [super destroyAllEntitiesWithName:ENTITY_NAME_SINGLE_ACTION];
}

@end
