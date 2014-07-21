//
//  NZGesture.h
//  Gesture
//
//  Created by Natalia Zarawska on 7/16/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <CoreData/CoreData.h>
@class NZClassLabel;
@class NZSensorDataSet;

static NSString *ENTITY_NAME_GESTURE = @"NZGesture";

@interface NZGesture : NSManagedObject

#pragma mark - attributes
@property (nonatomic, retain) NSDate * timeStampCreated;
@property (nonatomic, retain) NSDate * timeStampUpdated;
@property (nonatomic, retain) NSString * httpRequest;


#pragma mark - relationships
@property (nonatomic, retain) NSManagedObject *gestureSet;
@property (nonatomic, retain) NZClassLabel *label;
@property (nonatomic, retain) NSSet *negativeSamples;
@property (nonatomic, retain) NSSet *positiveSamples;
@end

@interface NZGesture (CoreDataGeneratedAccessors)

- (void)addNegativeSamplesObject:(NZSensorDataSet *)value;
- (void)removeNegativeSamplesObject:(NZSensorDataSet *)value;
- (void)addNegativeSamples:(NSSet *)values;
- (void)removeNegativeSamples:(NSSet *)values;

- (void)addPositiveSamplesObject:(NZSensorDataSet *)value;
- (void)removePositiveSamplesObject:(NZSensorDataSet *)value;
- (void)addPositiveSamples:(NSSet *)values;
- (void)removePositiveSamples:(NSSet *)values;

@end
