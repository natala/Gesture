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
