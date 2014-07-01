//
//  NZSensorDataSet.h
//  Gesture
//
//  Created by Natalia Zarawska on 6/26/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NZSensorDataSet : NSObject <NSCopying>

@property (nonatomic, retain) NSMutableArray *sensorData;
@property (nonatomic, retain) NSMutableDictionary *labeledSensorData;
@property (nonatomic, retain) NSString *label;
@property (nonatomic, retain) NSDate *timestamp;

@end
