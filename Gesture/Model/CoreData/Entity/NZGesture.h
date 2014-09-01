//
//  NZGesture.h
//  Gesture
//
//  Created by Natalia Zarawska on 9/1/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

static NSString *ENTITY_NAME_GESTURE = @"NZGesture";

@class NZAction, NZClassLabel, NZGestureSet, NZSensorDataSet;

@interface NZGesture : NSManagedObject

@property (nonatomic, retain) NSString * httpRequestMessageBody;
@property (nonatomic, retain) NSString * httpRequestUrl;
@property (nonatomic, retain) NSDate * timeStampCreated;
@property (nonatomic, retain) NSDate * timeStampUpdated;
@property (nonatomic, retain) NZAction *actionComposite;
@property (nonatomic, retain) NZGestureSet *gestureSet;
@property (nonatomic, retain) NZClassLabel *label;
@property (nonatomic, retain) NSSet *negativeSamples;
@property (nonatomic, retain) NSSet *positiveSamples;
@property (nonatomic, retain) NZAction *singleAction;
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
