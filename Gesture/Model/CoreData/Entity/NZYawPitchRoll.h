//
//  NZNZYawPitchRoll.h
//  Gesture
//
//  Created by Natalia Zarawska on 7/1/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <CoreData/CoreData.h>
//#import "NZSensorData.h"

static NSString *ENTITY_NAME_YAW_PITCH_ROLL = @"NZYawPitchRoll";

@class NZSensorData;

@interface NZYawPitchRoll : NSManagedObject

#pragma mark - attributes
@property (nonatomic, retain) NSNumber * pitch;
@property (nonatomic, retain) NSNumber * roll;
@property (nonatomic, retain) NSNumber * yaw;

#pragma mark - relationships
@property (nonatomic, retain) NZSensorData *sensorData;

@end
