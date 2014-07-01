//
//  NZSensorDataRecordingManager.h
//  Gesture
//
//  Created by Natalia Zarawska on 6/26/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NZSensorDataSet.h"
#import "NZSensorData.h"
#import "NZArduinoCommunicationManager.h"

@protocol NZSensorDataRecordingManagerObserver <NSObject>

@optional
- (void)didStartRecordingSensorData:(NZSensorDataSet *) sensorDataSet;
- (void)didPauseReordingSensorData:(NZSensorDataSet *) sensorDataSet;
- (void)didResumeRecordingSensorData:(NZSensorDataSet *) sensorDataSet;
- (void)didReceiveSensorData:(NZSensorData *) sensorData forSensorDataSer:(NZSensorDataSet *) sensorDataSet;
- (void)didStopRecordingSensorDataSet:(NZSensorDataSet *) sensorDataSet;

@end

@interface NZSensorDataRecordingManager : NSObject <NZArduinoCommunicationManagerDelegate>

/**
 * Create and return the singleton instance of the sensor data recording manager
 */
+ (NZSensorDataRecordingManager *) sharedManager;

@property (nonatomic, retain) NSMutableArray *sensorDataRecordingObservers;
@property (nonatomic, retain) NZSensorDataSet *currentSet;


- (BOOL)startRecordingNewSensorDataSet;
- (BOOL)restartRecordingCurrentDataSet;
- (void)pauseRecordingOfTheCurrentSensorDataSet;
- (void)resumeRecordingOfTheCurrentSensorDataSet;
- (void)stopRecordingCurrentSensorDataSet;

#pragma mark - manage observers
- (void)addRecordingObserver:(id<NZSensorDataRecordingManagerObserver>) observer;
- (void)removeRecordingObserver:(id<NZSensorDataRecordingManagerObserver>) observer;

@end
