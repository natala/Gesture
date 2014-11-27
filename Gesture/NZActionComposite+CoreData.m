//
//  NZActionComposite+CoreData.m
//  Gesture
//
//  Created by Natalia Zarawska on 7/1/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZActionComposite+CoreData.h"
#import "NSManagedObject+CoreData.h"
#import "NZLocation+CoreData.h"
#import "NZGesture.h"
#import "NZClassLabel.h"

@implementation NZActionComposite (CoreData)

#pragma mark - Create
+(NZActionComposite *)create
{
    NZActionComposite *action = (NZActionComposite *)[super createEntityWithName:ENTITY_NAME_ACTION_COMPOSITE];
    action.location = [NZLocation globalLocation];
    return action;
}

#pragma mark - Find
+ (NSArray *)findAll
{
    return [super findAllEntitiesWithName:ENTITY_NAME_ACTION_COMPOSITE];
}

+ (NSArray *)findAllSortedByName
{
    NSSortDescriptor *actionSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    return [[NZActionComposite findAll] sortedArrayUsingDescriptors:@[actionSortDescriptor]];
}

+ (NSArray *)findAllSortedByNameActionsForLocation:(NSString *)locationName
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"location.name == %@", locationName];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:ENTITY_NAME_ACTION_COMPOSITE];
    request.predicate = predicate;
    NSError *error = nil;
    NSArray *foundEntities = [[NZCoreDataManager sharedManager].managedObjectContext executeFetchRequest:request error:&error];
    
    return foundEntities;
}

+ (NZActionComposite *)findActionForLocation:(NSString *)locationName andGesture:(NSString *)gestureName
{    NSArray *actions = [NZActionComposite findAllSortedByNameActionsForLocation:locationName];
    if ([actions count] > 0) {
        for (NZActionComposite *action in actions) {
            for (NZGesture *gesture in action.gestureSingleReverse) {
                if ([gesture.label.name isEqualToString:gestureName]) {
                    return action;
                }
            }
        }
    }
    return nil;
}

+ (NZActionComposite *)findLates
{
#warning incomplete implementation
    NSLog(@"NZActionComposite find lates to be implemented!!!");
    return nil;
}

#pragma mark - Destroy
- (void)destroy
{
    [super destroy];
}

+ (void)destroyAll
{
    [super destroyAllEntitiesWithName:ENTITY_NAME_ACTION_COMPOSITE];
}

#pragma mark - Clone
- (NZActionComposite *)clone
{
    return (NZActionComposite *)[super clone];
}

@end
