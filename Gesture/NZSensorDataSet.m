//
//  NZSensorDataSet.m
//  Gesture
//
//  Created by Natalia Zarawska on 6/26/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZSensorDataSet.h"

@implementation NZSensorDataSet

- (id)init
{
    self = [super init];
    if (self) {
        self.sensorData = [[NSMutableArray alloc] init];
        self.labeledSensorData = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    NZSensorDataSet *newObj = [[NZSensorDataSet alloc] init];
    newObj.sensorData = [self.sensorData copyWithZone:zone];
    newObj.label = [self.label copyWithZone:zone];
    newObj.timestamp = [self.timestamp copyWithZone:zone];
    newObj.labeledSensorData = [self.labeledSensorData copyWithZone:zone];
    
    return newObj;
}

@end
