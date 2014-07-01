//
//  NZSensorData.h
//  Gesture
//
//  Created by Natalia Zarawska on 6/26/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NZLinearAcceleration.h"
#import "NZQuaternion.h"
#import "NZGravity.h"
#import "NZYawPitchRoll.h"

@interface NZSensorData : NSObject <NSCopying>

@property (nonatomic, retain) NZLinearAcceleration *linearAcceleration;
@property (nonatomic, retain) NZQuaternion *quaternion;
@property (nonatomic, retain) NZYawPitchRoll *yawPitchRoll;
@property (nonatomic, retain) NZGravity *gravity;

@end
