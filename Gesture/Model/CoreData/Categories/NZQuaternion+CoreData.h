//
//  NZSensorDataSet+CoreData.h
//  Gesture
//
//  Created by Natalia Zarawska on 7/1/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZQuaternion.h"

@interface NZQuaternion (CoreData)


+ (NZQuaternion*)create;

+ (NSArray *)findAll;

+ (NZQuaternion *)findLates;

- (void)destroy;

+ (void)destroyAll;

- (NSString *)valuesToString;

/**
 * performes min - max normalization
 */
- (void)normalize;

@end
