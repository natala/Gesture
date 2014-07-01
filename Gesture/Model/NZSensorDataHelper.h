//
//  NZSensorDataHelper.h
//  Gesture
//
//  Created by Natalia Zarawska on 6/26/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <math.h>
#import <GLKit/GLKit.h>
#import "NZSensorData.h"

@interface NZSensorDataHelper : NSObject

+ (NZGravity *)gravityFromQuaternion:(NZQuaternion *) quaternion;

+ (NZLinearAcceleration *)linearAccelerationFromRawAcceleration:(GLKVector3)rawAcceleration gravity:(NZGravity *)gravity andQuaternion:(NZQuaternion *)quaternion;

+ (NZYawPitchRoll *)yawPitchRollFromQuaternion:(NZQuaternion *)quaternion;

@end
