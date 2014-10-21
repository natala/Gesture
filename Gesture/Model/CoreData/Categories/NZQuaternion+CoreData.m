//
//  NZSensorDataSet+CoreData.m
//  Gesture
//
//  Created by Natalia Zarawska on 7/1/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZQuaternion+CoreData.h"
#import "NSManagedObject+CoreData.h"

static float kQuaternionsMaxValue = 1.0;
static float kQuaternionsMinValue = -1.0;

@implementation NZQuaternion (CoreData)

#pragma mark - Create
+(NZQuaternion *)create
{
    return (NZQuaternion *)[super createEntityWithName:ENTITY_NAME_QUATERNION];
}

#pragma mark - Find
+ (NSArray *)findAll
{
    return [super findAllEntitiesWithName:ENTITY_NAME_QUATERNION];
}

+ (NZQuaternion *)findLates
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
    [super destroyAllEntitiesWithName:ENTITY_NAME_QUATERNION];
}

- (NSString *)valuesToString
{
    NSString *string = [NSString stringWithFormat:@"%f\t%f\t%f\t%f", [self.w floatValue], [self.x floatValue], [self.y floatValue], [self.z floatValue]];
    return string;
}

- (void)normalize
{
    float w = ([self.w floatValue] - kQuaternionsMinValue) / (kQuaternionsMaxValue-kQuaternionsMinValue);
    float x = ([self.x floatValue] - kQuaternionsMinValue) / (kQuaternionsMaxValue-kQuaternionsMinValue);
    float y = ([self.y floatValue] - kQuaternionsMinValue) / (kQuaternionsMaxValue-kQuaternionsMinValue);
    float z = ([self.z floatValue] - kQuaternionsMinValue) / (kQuaternionsMaxValue-kQuaternionsMinValue);
    
    self.w = [NSNumber numberWithFloat:w];
    self.x = [NSNumber numberWithFloat:x];
    self.y = [NSNumber numberWithFloat:y];
    self.z = [NSNumber numberWithFloat:z];

}

@end
