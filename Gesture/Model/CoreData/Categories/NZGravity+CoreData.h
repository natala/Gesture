//
//  NZSensorDataSet+CoreData.h
//  Gesture
//
//  Created by Natalia Zarawska on 7/1/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZGravity.h"

@interface NZGravity (CoreData)


+ (NZGravity *)create;

+ (NSArray *)findAll;

+ (NZGravity *)findLates;

- (void)destroy;

+ (void)destroyAll;

- (NSString *)valuesToString;

/**
 * performes min - max normalization
 */
- (void)normalize;

@end
