//
//  NZGravity.m
//  Gesture
//
//  Created by Natalia Zarawska on 6/26/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZGravity.h"

@implementation NZGravity

- (id)copyWithZone:(NSZone *)zone
{
    NZGravity *newObj = [[NZGravity alloc] init];
    newObj.x = [self.x copyWithZone:zone];
    newObj.y = [self.y copyWithZone:zone];
    newObj.z = [self.z copyWithZone:zone];
    
    return newObj;
}

@end
