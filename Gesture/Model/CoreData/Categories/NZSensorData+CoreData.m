//
//  NZSensorDataSet+CoreData.m
//  Gesture
//
//  Created by Natalia Zarawska on 7/1/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZSensorData+CoreData.h"
#import "NZLinearAcceleration+CoreData.h"
#import "NZGravity+CoreData.h"
#import "NZQuaternion+CoreData.m"
#import "NZYawPitchRoll+CoreData.h"
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
    [self.linearAcceleration destroy];
    [self.gravity destroy];
    [self.quaternion destroy];
    [self.yawPitchRoll destroy];
    [super destroy];
}

+ (void)destroyAll
{
    [super destroyAllEntitiesWithName:ENTITY_NAME_SENSOR_DATA];
}

- (NZSensorData *)clone
{
    return (NZSensorData *)[super clone];
}

- (NSString *)sensorValuesAsString
{
    NSMutableString *string = [[NSMutableString alloc] initWithString:@""];
    [string appendString:[self.linearAcceleration valuesToString]];
    [string appendString:@"\t"];
    [string appendString:[self.quaternion valuesToString]];
    [string appendString:@"\t"];
    [string appendString:[self.yawPitchRoll valuesToString]];
    [string appendString:@"\t"];
    [string appendString:[self.gravity valuesToString]];
    return string;
}

- (void)normalize
{
    if (self.linearAcceleration)
        [self.linearAcceleration normalize];
    if (self.quaternion)
        [self.quaternion normalize];
    if (self.yawPitchRoll)
        [self.yawPitchRoll normalize];
    if (self.gravity)
        [self.gravity normalize]; // this is not normalizing gravity actually
  
}

@end
