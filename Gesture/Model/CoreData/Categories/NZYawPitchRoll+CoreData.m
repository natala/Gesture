//
//  NZSensorDataSet+CoreData.m
//  Gesture
//
//  Created by Natalia Zarawska on 7/1/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZYawPitchRoll+CoreData.h"
#import "NSManagedObject+CoreData.h"

@implementation NZYawPitchRoll (CoreData)

#pragma mark - Create
+(NZYawPitchRoll *)create
{
    return (NZYawPitchRoll *)[super createEntityWithName:ENTITY_NAME_YAW_PITCH_ROLL];
}

#pragma mark - Find
+ (NSArray *)findAll
{
    return [super findAllEntitiesWithName:ENTITY_NAME_YAW_PITCH_ROLL];
}

+ (NZYawPitchRoll *)findLates
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
    [super destroyAllEntitiesWithName:ENTITY_NAME_YAW_PITCH_ROLL];
}

@end
