//
//  NZSensorDataSet+CoreData.h
//  Gesture
//
//  Created by Natalia Zarawska on 7/1/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZClassLabel.h"

@interface NZClassLabel (CoreData)


+ (NZClassLabel *)create;

+ (NSArray *)findAll;

+ (NZClassLabel *)findLates;

- (void)destroy;

+ (void)destroyAll;

@end
