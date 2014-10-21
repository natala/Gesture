//
//  NZSensorDataSet+CoreData.m
//  Gesture
//
//  Created by Natalia Zarawska on 7/1/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZYawPitchRoll+CoreData.h"
#import "NSManagedObject+CoreData.h"

static float kYPRMaxValue = 180.0;
static float kYPRMinValue = -180.0;

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

- (NSString *)valuesToString
{
    NSString *string = [NSString stringWithFormat:@"%f\t%f\t%f", [self.yaw floatValue], [self.pitch floatValue], [self.roll floatValue]];
    return string;
}

- (void)normalize
{
    float yaw = ([self.yaw floatValue] - kYPRMinValue) / (kYPRMaxValue-kYPRMinValue);
    float pitch = ([self.pitch floatValue] - kYPRMinValue) / (kYPRMaxValue-kYPRMinValue);
    float roll = ([self.roll floatValue] - kYPRMinValue) / (kYPRMaxValue-kYPRMinValue);
    
    self.yaw = [NSNumber numberWithFloat:yaw];
    self.pitch = [NSNumber numberWithFloat:pitch];
    self.roll = [NSNumber numberWithFloat:roll];
}

@end
