//
//  NZGesture+CoreData.m
//  Gesture
//
//  Created by Natalia Zarawska on 7/16/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZGesture+CoreData.h"
#import "NSManagedObject+CoreData.h"

@implementation NZGesture (CoreData)

#pragma mark - Create
+(NZGesture *)create
{
    return (NZGesture *)[super createEntityWithName:ENTITY_NAME_GESTURE];
}

#pragma mark - Find
+ (NSArray *)findAll
{
    return [super findAllEntitiesWithName:ENTITY_NAME_GESTURE];
}

+ (NZGesture *)findLates
{
#warning incomplete implementation
    NSLog(@"NZSensorDataSet find lates to be implemented!!!");
    return nil;
}

#pragma mark - Destroy
- (void)destroy
{
    [super destroy];
}

+ (void)destroyAll
{
    [super destroyAllEntitiesWithName:ENTITY_NAME_GESTURE];
}

#pragma mark - Clone
- (NZGesture *)clone
{
    return (NZGesture *)[super clone];
}



@end
