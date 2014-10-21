//
//  NZSensorDataSet+CoreData.m
//  Gesture
//
//  Created by Natalia Zarawska on 7/1/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZLinearAcceleration+CoreData.h"
#import "NSManagedObject+CoreData.h"

static float kAccelerationMaxValue = 19660; //32767; // 2^(16-1)-1
static float kAccelerationMinValue = -19660; // -32768; // -2^(16-1)

@implementation NZLinearAcceleration (CoreData)

#pragma mark - Create
+(NZLinearAcceleration *)create
{
    return (NZLinearAcceleration *)[super createEntityWithName:ENTITY_NAME_LINEAR_ACCELERATION];
}

#pragma mark - Find
+ (NSArray *)findAll
{
    return [super findAllEntitiesWithName:ENTITY_NAME_LINEAR_ACCELERATION];
}

+ (NZLinearAcceleration *)findLates
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
    [super destroyAllEntitiesWithName:ENTITY_NAME_LINEAR_ACCELERATION];
}

- (NSString *)valuesToString
{
    NSString *string = [NSString stringWithFormat:@"%f\t%f\t%f", [self.x floatValue], [self.y floatValue], [self.z floatValue]];
    return string;
    
}

- (void)normalize
{
    float x = ([self.x floatValue] - kAccelerationMinValue) / (kAccelerationMaxValue-kAccelerationMinValue);
    float y = ([self.y floatValue] - kAccelerationMinValue) / (kAccelerationMaxValue-kAccelerationMinValue);
    float z = ([self.z floatValue] - kAccelerationMinValue) / (kAccelerationMaxValue-kAccelerationMinValue);
     
    self.x = [NSNumber numberWithFloat:x];
    self.y = [NSNumber numberWithFloat:y];
    self.z = [NSNumber numberWithFloat:z];
}

@end
