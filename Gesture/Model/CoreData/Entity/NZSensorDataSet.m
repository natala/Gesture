//
//  NZSensorDataSet.m
//  Gesture
//
//  Created by Natalia Zarawska on 7/1/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZSensorDataSet.h"

@implementation NZSensorDataSet

#pragma mark - attributes
@dynamic name;
@dynamic timeStampCreated;
@dynamic timeStampUpdate;

#pragma mark - relationships
@dynamic gestureNegative;
@dynamic gesturePositive;
@dynamic sensorData;
@dynamic sample0;

@end
