//
//  NZGestureSet+CoreData.m
//  Gesture
//
//  Created by Natalia Zarawska on 7/16/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZGestureSet+CoreData.h"
#import "NZGesture+CoreData.h"
#import "NSManagedObject+CoreData.h"

@implementation NZGestureSet (CoreData)

#pragma mark - Create
+(NZGestureSet *)create
{
    return (NZGestureSet *)[super createEntityWithName:ENTITY_NAME_GESTURE_SET];
}

#pragma mark - Find
+ (NSArray *)findAll
{
    return [super findAllEntitiesWithName:ENTITY_NAME_GESTURE_SET];
}

+ (NZGestureSet *)findLates
{
#warning incomplete implementation
    NSLog(@"NZSensorDataSet find lates to be implemented!!!");
    return nil;
}

+ (NSArray *)findAllSortetByLabel
{
    NSSortDescriptor *gestureSortDescripor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    return [[NZGestureSet findAll]sortedArrayUsingDescriptors:@[gestureSortDescripor]];
}

+ (NZGestureSet *)findWithName:(NSString *)name
{
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:ENTITY_NAME_GESTURE_SET];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", name];
	fetchRequest.predicate = predicate;
	fetchRequest.sortDescriptors = @[];
    
	NSError *error = nil;
	NSArray *fetchedEntities = [[NZCoreDataManager sharedManager].managedObjectContext executeFetchRequest:fetchRequest
																									 error:&error];
	if (!fetchedEntities) {
		NSLog(@"Error: %@", error);
	}
    
	return [fetchedEntities objectAtIndex:0];
}


#pragma mark - Destroy
- (void)destroy
{
    for (NZGesture *gesture in self.gestures) {
        [gesture destroy];
    }
    [super destroy];
}

+ (void)destroyAll
{
    [super destroyAllEntitiesWithName:ENTITY_NAME_GESTURE_SET];
}

#pragma mark - Clone
- (NZGestureSet *)clone
{
    return (NZGestureSet *)[super clone];
}


@end
