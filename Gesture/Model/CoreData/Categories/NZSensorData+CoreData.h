//
//  NZSensorDataSet+CoreData.h
//  Gesture
//
//  Created by Natalia Zarawska on 7/1/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZSensorData.h"

@interface NZSensorData (CoreData)


+ (NZSensorData *)create;

+ (NSArray *)findAll;

+ (NZSensorData *)findLates;

- (void)destroy;

+ (void)destroyAll;

- (NZSensorData *)clone;

- (NSString *)sensorValuesAsString;

/**
 * perfoems min - max normalization for all data types (linear acceleration, orientations, gravity)
 */
- (void)normalize;

@end
