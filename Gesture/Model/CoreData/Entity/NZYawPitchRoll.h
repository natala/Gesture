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

@property (nonatomic, strong) NSNumber *yaw;
@property (nonatomic, strong) NSNumber *pitch;
@property (nonatomic, strong) NSNumber *roll;
@property (nonatomic, strong) NZSensorData *sensorData;

@end
