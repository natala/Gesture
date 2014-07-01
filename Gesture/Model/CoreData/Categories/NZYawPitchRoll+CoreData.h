//
//  NZSensorDataSet+CoreData.h
//  Gesture
//
//  Created by Natalia Zarawska on 7/1/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZYawPitchRoll.h"

@interface NZYawPitchRoll (CoreData)


+ (NZYawPitchRoll *)create;

+ (NSArray *)findAll;

+ (NZYawPitchRoll *)findLates;

- (void)destroy;

+ (void)destroyAll;

@end
