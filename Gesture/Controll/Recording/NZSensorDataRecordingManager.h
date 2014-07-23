//
//  NZSensorDataRecordingManager.h
//  Gesture
//
//  Created by Natalia Zarawska on 6/26/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NZSensorDataSet+CoreData.h"
#import "NZSensorData+CoreData.h"
#import "NZArduinoCommunicationManager.h"

@protocol NZSensorDataRecordingManagerObserver <NSObject>

@optional
- (void)didStartRecordingSensorData:(NZSensorDataSet *) sensorDataSet;
- (void)didPauseReordingSensorData:(NZSensorDataSet *) sensorDataSet;
- (void)didResumeRecordingSensorData:(NZSensorDataSet *) sensorDataSet;
- (void)didReceiveSensorData:(NZSensorData *) sensorData forSensorDataSer:(NZSensorDataSet *) sensorDataSet;
- (void)didStopRecordingSensorDataSet:(NZSensorDataSet *) sensorDataSet;
- (void)disconnected;
- (void)connected;

@end

@interface NZSensorDataRecordingManager : NSObject <NZArduinoCommunicationManagerDelegate>

/**
 * Create and return the singleton instance of the sensor data recording manager
 */
+ (NZSensorDataRecordingManager *) sharedManager;

@property (nonatomic, retain) NSMutableArray *sensorDataRecordingObservers;
@property (nonatomic, retain) NZSensorDataSet *currentSet;

/**
 * Sets up the connection with the arduino (tells the arduino connection manager to connect)
 * @return weather was able to connect
 */
- (BOOL)prepareForRecordingSensorDataSet;

/**
 * Informs the arduino connection manager to start recording sensor data
 * @note Updates the creation time of the current sensor data set and informs the observer about the new state
 * @return weather the arduino connection manager was able to start recording sensor data
 */
- (BOOL)startRecordingNewSensorDataSet;

/**
 * Informs the arduino connection manager to stop notifing whenever new data was received from the arduini
 * @note the sensor data recording manager sets the delegate of the arduino connection manager to nil
 */
- (void)stopRecordingCurrentSensorDataSet;

/**
 * Informs the arduino connection manager to disconnect form the arduino
 */
- (void)disconnect;

- (BOOL)restartRecordingCurrentDataSet;
- (void)pauseRecordingOfTheCurrentSensorDataSet;
- (void)resumeRecordingOfTheCurrentSensorDataSet;

/**
 * checks if the arduino is connected
 * @note doesn't mean that the recording sensor data recording manager is reciving data yet. For this call the isReceivingData
 * @return weather the arduino is connected
 */
- (BOOL)isConnected;

/**
 * checks if the sendora data recording manager is receiving data form the arduino
 * @note is means basically that it is the delegate of the arduino connection manager
 * @return weather is receiving sensor data
 */
- (BOOL)isReceivingData;

#pragma mark - manage observers
- (void)addRecordingObserver:(id<NZSensorDataRecordingManagerObserver>) observer;
- (void)removeRecordingObserver:(id<NZSensorDataRecordingManagerObserver>) observer;

@end
