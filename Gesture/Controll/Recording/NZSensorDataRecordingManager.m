//
//  NZSensorDataRecordingManager.m
//  Gesture
//
//  Created by Natalia Zarawska on 6/26/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZSensorDataRecordingManager.h"
#import "NZLinearAcceleration.h"

@implementation NZSensorDataRecordingManager

#pragma mark - singleton
+ (NZSensorDataRecordingManager *)sharedManager
{
    static NZSensorDataRecordingManager *sharedManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [NZSensorDataRecordingManager new];
    });
    
    return sharedManager;
}

#pragma mark - init
- (id)init
{
    self = [super init];
    if (self) {
        self.sensorDataRecordingObservers = [NSMutableArray array];
    }
    return self;
}

#pragma mark - manage observers
- (void)addRecordingObserver:(id<NZSensorDataRecordingManagerObserver>)observer
{
    [self.sensorDataRecordingObservers addObject:observer];
}

- (void)removeRecordingObserver:(id<NZSensorDataRecordingManagerObserver>)observer
{
    [self.sensorDataRecordingObservers removeObject:observer];
}

#pragma mark - NZArduinoCommunicationManagerDelegate
- (void)didReceiveSensorData:(NZSensorData *)sensorData
{
    [self.currentSet addSensorDataObject:sensorData];
    for (id<NZSensorDataRecordingManagerObserver>observer in self.sensorDataRecordingObservers){
        if ([observer respondsToSelector:@selector(didReceiveSensorData:forSensorDataSer:)]) {
            [observer didReceiveSensorData:sensorData forSensorDataSer:self.currentSet];
        }
    }
}

- (BOOL)prepareForRecordingSensorDataSet
{
    if ([[NZArduinoCommunicationManager sharedManager] connect]) {
        for (id<NZSensorDataRecordingManagerObserver>observer in self.sensorDataRecordingObservers){
            if ([observer respondsToSelector:@selector(connected)]) {
                [observer connected];
            }
        }
        return YES;
    }
    return NO;
}

- (BOOL)startRecordingNewSensorDataSet
{
    self.currentSet = [NZSensorDataSet create];
    self.currentSet.timeStampCreated = [NSDate date];
    self.currentSet.timeStampUpdate = self.currentSet.timeStampCreated;
    // now the sensor data recording manager will be notified whenever the arduino connection manager receives new data
    [NZArduinoCommunicationManager sharedManager].delegate = self;
    BOOL startedReceiving = [[NZArduinoCommunicationManager sharedManager] startReceivingSensorData];
    
    if (startedReceiving) {
        for (id<NZSensorDataRecordingManagerObserver>observer in self.sensorDataRecordingObservers){
            if ([observer respondsToSelector:@selector(didStartRecordingSensorData:)]) {
                [observer didStartRecordingSensorData:self.currentSet];
            }
        }
        return YES;
    }
    return NO;
}

- (BOOL)restartRecordingCurrentDataSet
{
    if (self.currentSet) {
        return [self startRecordingNewSensorDataSet];
    }
    
    self.currentSet = [NZSensorDataSet create];
    self.currentSet.timeStampCreated = [NSDate date];
    self.currentSet.timeStampUpdate = self.currentSet.timeStampCreated;
    
    for (id<NZSensorDataRecordingManagerObserver> observer in self.sensorDataRecordingObservers) {
        if ([observer respondsToSelector:@selector(didStartRecordingSensorData:)]) {
            [observer didStartRecordingSensorData:self.currentSet];
        }
    }
    
    return YES;
}

- (void)pauseRecordingOfTheCurrentSensorDataSet
{
    if (self.currentSet) {
        [[NZArduinoCommunicationManager sharedManager] stopReceivingSensorData];
        
        for (id<NZSensorDataRecordingManagerObserver> observer in self.sensorDataRecordingObservers) {
            if ([observer respondsToSelector:@selector(didPauseReordingSensorData:)]) {
                [observer didPauseReordingSensorData:self.currentSet];
            }
        }
    }
}

- (void)resumeRecordingOfTheCurrentSensorDataSet
{
    if (!self.currentSet) {
        [self startRecordingNewSensorDataSet];
    } else {
        [NZArduinoCommunicationManager sharedManager].delegate = self;
        [[NZArduinoCommunicationManager sharedManager] startReceivingSensorData];
    }
    
    for (id<NZSensorDataRecordingManagerObserver> observer in self.sensorDataRecordingObservers) {
        if ([observer respondsToSelector:@selector(didResumeRecordingSensorData:)]) {
            [observer didResumeRecordingSensorData: self.currentSet];
        }
    }
}

- (void)disconnect
{
    //[self stopRecordingCurrentSensorDataSet];
    self.currentSet = nil;
    [[NZArduinoCommunicationManager sharedManager] disconnect];
}

- (void)stopRecordingCurrentSensorDataSet
{
    [NZArduinoCommunicationManager sharedManager].delegate = nil;
    for (id<NZSensorDataRecordingManagerObserver> observer in self.sensorDataRecordingObservers) {
        if ([observer respondsToSelector:@selector(didStopRecordingSensorDataSet:)]) {
            [observer didStopRecordingSensorDataSet:self.currentSet];
        }
    }
    self.currentSet = nil;
}

@end
