//
//  NZClassLabel.h
//  Gesture
//
//  Created by Natalia Zarawska on 7/1/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <CoreData/CoreData.h>

static NSString *ENTITY_NAME_CLASS_LABEL = @"NZClassLabel";

@interface NZClassLabel : NSManagedObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *index;

@property (nonatomic, retain) NSSet *sensorData;
@end

@interface NZClassLabel (CoreDataGeneratedAccessors)

- (void)addSensorDataObject:(NZSensorData *)value;
- (void)removeSensorDataObject:(NZSensorData *)value;
- (void)addSensorData:(NSSet *)values;
- (void)removeSensorData:(NSSet *)values;

@end
