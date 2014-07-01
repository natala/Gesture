//
//  NZSensorData.h
//  Gesture
//
//  Created by Natalia Zarawska on 7/1/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <CoreData/CoreData.h>
/*#import "NZClassLabel.h"
#import "NZLinearAcceleration.h"
#import "NZSensorDataSet.h"
#import "NZGravity.h"
#import "NZYawPitchRoll.h"
#import "NZQuaternion.h"
*/

@class NZClassLabel, NZLinearAcceleration, NZSensorDataSet, NZYawPitchRoll, NZGravity, NZQuaternion;

static NSString *ENTITY_NAME_SENSOR_DATA = @"NZSensorData";

@interface NZSensorData : NSManagedObject

@property (nonatomic, strong) NSDate *timeStamp;
@property (nonatomic, strong) NZClassLabel *classLabel;
@property (nonatomic, strong) NZLinearAcceleration *linearAcceleration;
@property (nonatomic, strong) NZSensorDataSet *sensorDataSet;
@property (nonatomic, strong) NZGravity *gravity;
@property (nonatomic, strong) NZYawPitchRoll *yawPitchRoll;
@property (nonatomic, strong) NZQuaternion *quaternion;


@end