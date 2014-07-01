//
//  NZSensorDataSet.h
//  Gesture
//
//  Created by Natalia Zarawska on 7/1/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <CoreData/CoreData.h>

@class NZSensorData;

static NSString *ENTITY_NAME_SENSOR_DATA_SET = @"NZSensorDataSet";

@interface NZSensorDataSet : NSManagedObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSDate *timeStamp;
@property (nonatomic, retain) NSSet *sensorData;
@end

@interface NZSensorDataSet (CoreDataGeneratedAccessors)

- (void)addSensorDataObject:(NZSensorData *)value;
- (void)removeSensorDataObject:(NZSensorData *)value;
- (void)addSensorData:(NSSet *)values;
- (void)removeSensorData:(NSSet *)values;


@end
