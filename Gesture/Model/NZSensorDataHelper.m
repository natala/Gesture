//
//  NZSensorDataHelper.m
//  Gesture
//
//  Created by Natalia Zarawska on 6/26/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZSensorDataHelper.h"
#import "NZGravity+CoreData.h"
#import "NZLinearAcceleration+CoreData.h"
#import "NZYawPitchRoll+CoreData.h"
#import "NZQuaternion.h"

@implementation NZSensorDataHelper

+ (NZGravity *)gravityFromQuaternion:(NZQuaternion *)quaternion
{
    GLKQuaternion q = [self transformQuaternion:quaternion];
    
    NZGravity *gravity = [NZGravity create];
    
    gravity.x = [NSNumber numberWithFloat:(2 * (q.x * q.z - q.w * q.y))];
    gravity.y = [NSNumber numberWithFloat:(2 * (q.w * q.x + q.y * q.z))];
    gravity.z = [NSNumber numberWithFloat:(q.w * q.w - q.x * q.x - q.y * q.y + q.z * q.z)];
    
    return gravity;
}

+ (NZLinearAcceleration *)linearAccelerationFromRawAcceleration:(GLKVector3)rawAcceleration gravity:(NZGravity *)gravity andQuaternion:(NZQuaternion *)quaternion
{
    GLKQuaternion q = [self transformQuaternion:quaternion];
    
    GLKVector3 linearAccelerationVector = GLKVector3Make(0, 0, 0);
    
    linearAccelerationVector.x = rawAcceleration.x - (2 * (q.x * q.z - q.w * q.y)) * 8192;
    linearAccelerationVector.y = rawAcceleration.y - (2 * (q.w * q.x + q.y * q.z)) * 8192;
    linearAccelerationVector.z = rawAcceleration.z - (q.w * q.w - q.x * q.x - q.y * q.y + q.z * q.z) * 8192;
    
    NZLinearAcceleration *linearAcceleration = [NZLinearAcceleration create];
    
    linearAcceleration.x = [NSNumber numberWithFloat:linearAccelerationVector.x];
    linearAcceleration.y = [NSNumber numberWithFloat:linearAccelerationVector.y];
    linearAcceleration.z = [NSNumber numberWithFloat:linearAccelerationVector.z];
    
    return linearAcceleration;
}

+ (NZYawPitchRoll *)yawPitchRollFromQuaternion:(NZQuaternion *)quaternion
{
    GLKQuaternion q = [self transformQuaternion:quaternion];
    
    NZYawPitchRoll *ypr = [NZYawPitchRoll create];
    
    ypr.yaw   = [NSNumber numberWithFloat:180.0 / M_PI * atan2f(2.0 * (q.y * q.z + q.w * q.x), q.w * q.w - q.x * q.x - q.y * q.y + q.z * q.z)];
    ypr.pitch = [NSNumber numberWithFloat:180.0 / M_PI * asinf(-2.0 * (q.x * q.z - q.w * q.y))];
    ypr.roll  = [NSNumber numberWithFloat:180.0 / M_PI * atan2f(2.0 * (q.x * q.y + q.w * q.z), q.w * q.w + q.x * q.x - q.y * q.y - q.z * q.z)];
    
    return ypr;
}

#pragma mark - Helper

+ (GLKQuaternion)transformQuaternion:(NZQuaternion *)quaternion
{
    return GLKQuaternionMake([quaternion.x floatValue], [quaternion.y floatValue], [quaternion.z floatValue], [quaternion.w floatValue]);
}

@end
