//
//  NZSensorData.m
//  Gesture
//
//  Created by Natalia Zarawska on 6/26/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZSensorData.h"

@implementation NZSensorData

- (id)copyWithZone:(NSZone *)zone
{
    NZSensorData *newSensorData = [[NZSensorData alloc] init];
    newSensorData.linearAcceleration = [self.linearAcceleration copyWithZone:zone];
    newSensorData.gravity = [self.gravity copyWithZone:zone];
    newSensorData.yawPitchRoll = [self.yawPitchRoll copyWithZone:zone];
    newSensorData.quaternion = [self.quaternion copyWithZone:zone];
    
    return newSensorData;
}

@end
