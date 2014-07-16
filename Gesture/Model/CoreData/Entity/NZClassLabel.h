//
//  NZClassLabel.h
//  Gesture
//
//  Created by Natalia Zarawska on 7/1/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <CoreData/CoreData.h>

static NSString *ENTITY_NAME_CLASS_LABEL = @"NZClassLabel";

@class NZSensorData;

@interface NZClassLabel : NSManagedObject

#pragma mark - attributes
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSNumber *index;

#pragma mark - relationships
@property (nonatomic, retain) NSManagedObject *gesture;

@end

