//
//  NZSensorDataSet+CoreData.m
//  Gesture
//
//  Created by Natalia Zarawska on 7/1/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZSensorData+CoreData.h"
#import "NSManagedObject+CoreData.h"

@implementation NZSensorData (CoreData)

#pragma mark - Create
+(NZSensorData *)create
{
    return (NZSensorData *)[super createEntityWithName:ENTITY_NAME_SENSOR_DATA];
}

#pragma mark - Find
+ (NSArray *)findAll
{
    return [super findAllEntitiesWithName:ENTITY_NAME_SENSOR_DATA];
}

+ (NZSensorData *)findLates
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
    [super destroyAllEntitiesWithName:ENTITY_NAME_SENSOR_DATA];
}

- (NZSensorData *)clone
{
    return [super clone];
}

@end
