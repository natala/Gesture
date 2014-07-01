//
//  NZNZQuaternion.h
//  Gesture
//
//  Created by Natalia Zarawska on 7/1/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <CoreData/CoreData.h>
//#import "NZSensorData.h"

static NSString *ENTITY_NAME_QUATERNION = @"NZQuaternion";

@class NZSensorData;

@interface NZQuaternion : NSManagedObject

@property (nonatomic, strong) NSNumber *w;
@property (nonatomic, strong) NSNumber *x;
@property (nonatomic, strong) NSNumber *y;
@property (nonatomic, strong) NSNumber *z;
@property (nonatomic, strong) NZSensorData *sensorData;

@end
