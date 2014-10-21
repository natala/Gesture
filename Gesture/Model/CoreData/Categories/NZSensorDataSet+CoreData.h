//
//  NZSensorDataSet+CoreData.h
//  Gesture
//
//  Created by Natalia Zarawska on 7/1/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZSensorDataSet.h"

@interface NZSensorDataSet (CoreData)


+ (NZSensorDataSet *)create;

+ (NSArray *)findAll;

+ (NZSensorDataSet *)findLates;

- (void)destroy;

+ (void)destroyAll;

- (NZSensorDataSet *)clone;

- (NSString *)sensorDataSetToString;

@end
