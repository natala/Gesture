//
//  NZSensorData.h
//  Gesture
//
//  Created by Natalia Zarawska on 7/1/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <CoreData/CoreData.h>

@class NZClassLabel, NZLinearAcceleration, NZSensorDataSet, NZYawPitchRoll, NZGravity, NZQuaternion;

static NSString *ENTITY_NAME_SENSOR_DATA = @"NZSensorData";

@interface NZSensorData : NSManagedObject


#pragma mark - attributes
@property (nonatomic, retain) NSDate * timeStampRecoded;

#pragma mark - relationships
@property (nonatomic, retain) NZGravity *gravity;
@property (nonatomic, retain) NZLinearAcceleration *linearAcceleration;
@property (nonatomic, retain) NZQuaternion *quaternion;
@property (nonatomic, retain) NZSensorDataSet *sensorDataSet;
@property (nonatomic, retain) NZYawPitchRoll *yawPitchRoll;


@end