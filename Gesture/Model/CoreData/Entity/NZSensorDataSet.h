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

#pragma mark - attributes
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * timeStampCreated;
@property (nonatomic, retain) NSDate * timeStampUpdate;

#pragma mark - relationships
@property (nonatomic, retain) NSManagedObject *gestureNegative;
@property (nonatomic, retain) NSManagedObject *gesturePositive;
@property (nonatomic, retain) NSSet *sensorData;
@property (nonatomic, retain) NZSensorData *sample0;

@end

@interface NZSensorDataSet (CoreDataGeneratedAccessors)

- (void)addSensorDataObject:(NZSensorData *)value;
- (void)removeSensorDataObject:(NZSensorData *)value;
- (void)addSensorData:(NSSet *)values;
- (void)removeSensorData:(NSSet *)values;


@end

