//
//  NZSensorDataRecordingManager.m
//  Gesture
//
//  Created by Natalia Zarawska on 6/26/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZSensorDataRecordingManager.h"

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
    NZSensorData *testSensorData = [sensorData copy];
    [self.currentSet.sensorData addObject:[sensorData copy]];
    for (id<NZSensorDataRecordingManagerObserver>observer in self.sensorDataRecordingObservers){
        if ([observer respondsToSelector:@selector(didReceiveSensorData:forSensorDataSer:)]) {
            [observer didReceiveSensorData:sensorData forSensorDataSer:self.currentSet];
        }
    }
}

- (BOOL)startRecordingNewSensorDataSet
{
    self.currentSet = [[NZSensorDataSet alloc] init];
    self.currentSet.timestamp = [NSDate date];
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
    
    self.currentSet = [[NZSensorDataSet alloc] init];
    self.currentSet.timestamp = [NSDate date];
    
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

- (void)stopRecordingCurrentSensorDataSet
{
    [NZArduinoCommunicationManager sharedManager].delegate = nil;
    [[NZArduinoCommunicationManager sharedManager] stopReceivingSensorData];
    
    for (id<NZSensorDataRecordingManagerObserver> observer in self.sensorDataRecordingObservers) {
        if ([observer respondsToSelector:@selector(didStopRecordingSensorDataSet:)]) {
            [observer didStopRecordingSensorDataSet:self.currentSet];
        }
    }
}

@end
