//
//  NZYawPitchRoll.m
//  Gesture
//
//  Created by Natalia Zarawska on 6/26/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZYawPitchRoll.h"

@implementation NZYawPitchRoll

- (id)copyWithZone:(NSZone *)zone
{
    NZYawPitchRoll *newObj = [[NZYawPitchRoll alloc] init];
    newObj.yaw = [self.yaw copyWithZone:zone];
    newObj.pitch = [self.pitch copyWithZone:zone];
    newObj.roll = [self.roll copyWithZone:zone];
    
    return newObj;
}

@end
