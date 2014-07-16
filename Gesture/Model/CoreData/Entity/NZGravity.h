//
//  NZGravity.h
//  Gesture
//
//  Created by Natalia Zarawska on 7/1/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <CoreData/CoreData.h>
//#import "NZSensorData.h"

static NSString *ENTITY_NAME_GRAVITY = @"NZGravity";

@class NZSensorData;

@interface NZGravity : NSManagedObject

#pragma mark - attributes
@property (nonatomic, retain) NSNumber * x;
@property (nonatomic, retain) NSNumber * y;
@property (nonatomic, retain) NSNumber * z;

#pragma mark - relationships
@property (nonatomic, retain) NZSensorData *sensorData;

@end