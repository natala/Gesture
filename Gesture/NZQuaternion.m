//
//  NZQuaternion.m
//  Gesture
//
//  Created by Natalia Zarawska on 6/26/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZQuaternion.h"

@implementation NZQuaternion

- (id)copyWithZone:(NSZone *)zone
{
    NZQuaternion *newObj = [[NZQuaternion alloc] init];
    newObj.w = [self.w copyWithZone:zone];
    newObj.x = [self.x copyWithZone:zone];
    newObj.y = [self.y copyWithZone:zone];
    newObj.z = [self.z copyWithZone:zone];
    
    return newObj;
}

@end
