//
//  NZLinearAcceleration.m
//  Gesture
//
//  Created by Natalia Zarawska on 6/26/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZLinearAcceleration.h"

@implementation NZLinearAcceleration

-(id)copyWithZone:(NSZone *)zone
{
    NZLinearAcceleration *newObj = [[NZLinearAcceleration alloc] init];
    newObj.x = [self.x copyWithZone:zone];
    newObj.y = [self.y copyWithZone:zone];
    newObj.z = [self.z copyWithZone:zone];
    
    return newObj;
}

@end
