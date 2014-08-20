//
//  NZArduinoCommunicationManager.m
//  Gest
//
//  Created by Natalia Zarawska on 6/26/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZArduinoCommunicationManager.h"
#import <math.h>
#import <GLKit/GLKit.h>
#import "NZQuaternion+CoreData.h"
#import "NZLinearAcceleration+CoreData.h"
#import "NZSensorData+CoreData.h"
#import "NZGravity+CoreData.h"
#import "NZYawPitchRoll+CoreData.h"
#import "NZSensorDataHelper.h"

@implementation NZArduinoCommunicationManager

#pragma mark - Singleton

+ (NZArduinoCommunicationManager *)sharedManager
{
    static NZArduinoCommunicationManager *sharedManager = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedManager = [NZArduinoCommunicationManager new];
    });
    
    return sharedManager;
}

#pragma mark - Init

- (id)init
{
    self = [super init];
    if (self) {
        [BLEDiscovery sharedInstance].discoveryDelegate = self;
        [BLEDiscovery sharedInstance].peripheralDelegate = self;
        
        [[BLEDiscovery sharedInstance] startScanningForSupportedUUIDs];
    }
    return self;
}

- (BOOL)isAbleToReceiveSensorData
{
    NSLog(@"Found Peripherals: %d", [BLEDiscovery sharedInstance].foundPeripherals.count);
    return [BLEDiscovery sharedInstance].foundPeripherals.count == 1;
}

- (BOOL)isConnected
{
    return [[BLEDiscovery sharedInstance].connectedPeripherals count] == 1;
}

#pragma mark - BLEDiscoveryDelegate

- (void)discoveryDidRefresh
{
    NSLog(@"discoveryDidRefresh");
}

- (void)peripheralDiscovered:(CBPeripheral *)peripheral
{
    NSLog(@"peripheralDiscovered:%@", peripheral);
}

- (void)discoveryStatePoweredOff
{
    NSLog(@"discoveryStatePoweredOff");
}

#pragma mark - Helpers

- (void)connectToPeripherals
{
    NSLog(@"Connect to Peripherals ...");
    [[BLEDiscovery sharedInstance] connectToAllFoundPeripherals];
}

- (void)disconnectFromPeripherals
{
    NSLog(@"Disconnect from Peripherals ...");
    
    [[BLEDiscovery sharedInstance] disconnectConnectedPeripherals];
}

#pragma mark BLEServiceProtocol

- (void)bleServiceDidConnect:(BLEService *)service
{
    service.delegate = self;
    service.dataDelegate = self;
   // [self.delegate updateRecordingState:@"connected"];
    NSLog(@"bleServiceDidConnect:%@", service);
}

- (void)bleServiceDidDisconnect:(BLEService *)service
{
    NSLog(@"bleServiceDidDisconnect:%@", service);
}

- (void)bleServiceIsReady:(BLEService *)service
{
    NSLog(@"bleServiceIsReady:%@", service);
}

- (void)bleServiceDidReset
{
    NSLog(@"bleServiceDidReset");
}

- (void)reportMessage:(NSString *)message
{
    NSLog(@"reportMessage: %@", message);
}

#pragma mark - BLEServiceDataDelegate

- (void)didReceiveData:(uint8_t *)data length:(NSInteger)length
{
    NZSensorData *sensorData = [NZSensorData create];
    sensorData.timeStampRecoded = [NSDate date];
    
   // sensorData = [NSDate date];
   // sensorData.sensorID = [NSNumber numberWithInt:data[14]];
    
    uint8_t header = 85;    // 85 == 01010101xb
    uint8_t ending = 170;   // 170 == 10101010xb
    
    if ( (header != data[0]) || (ending != data[16]) ) {
        NSLog(@"received package is incomaptible with the defined ring package");
        return;
    }
    
    int buttonState = data[1];
    NSLog(@"button: %d", buttonState);
    // Quaternion
    float q[] = { 0.0f, 0.0f, 0.0f, 0.0f };
    
    q[0] = ((data[8] << 8) | data[9]) / 16384.0f;
    q[1] = ((data[10] << 8) | data[11]) / 16384.0f;
    q[2] = ((data[12] << 8) | data[13]) / 16384.0f;
    q[3] = ((data[14] << 8) | data[15]) / 16384.0f;
    
    for (int i = 0; i < 4; i++) {
        if (q[i] >= 2.0f) {
            q[i] -= 4.0f;
        }
    }
    
    // Raw Acceleration
    GLKVector3 rawAcceleration = GLKVector3Make(0, 0, 0);
    
    rawAcceleration.x = (short)((data[2] << 8) | data[3]);
    rawAcceleration.y = (short)((data[4] << 8) | data[5]);
    rawAcceleration.z = (short)((data[6] << 8) | data[7]);
    
  //  NSLog(@"Raw Acceleration: %f, %f, %f", rawAcceleration.x, rawAcceleration.y, rawAcceleration.z);
    
    // Conversion into KneeHapp proprietary model objects
    NZQuaternion *quaternion = [NZQuaternion create];
    
    quaternion.w = [NSNumber numberWithFloat:q[0]];
    quaternion.x = [NSNumber numberWithFloat:q[1]];
    quaternion.y = [NSNumber numberWithFloat:q[2]];
    quaternion.z = [NSNumber numberWithFloat:q[3]];
    
    sensorData.quaternion = quaternion;
    sensorData.gravity = [NZSensorDataHelper gravityFromQuaternion:quaternion];
   // NSLog(@"Gravity:  %@, %@, %@", sensorData.gravity.x, sensorData.gravity.y, sensorData.gravity.z);
    sensorData.yawPitchRoll = [NZSensorDataHelper yawPitchRollFromQuaternion:quaternion];
    sensorData.linearAcceleration = [NZSensorDataHelper linearAccelerationFromRawAcceleration:rawAcceleration gravity:sensorData.gravity andQuaternion:quaternion];
   // NSLog(@"Linear acceleration:  %@, %@, %@", sensorData.linearAcceleration.x, sensorData.linearAcceleration.y, sensorData.linearAcceleration.z);
    
    
    // Notify delegate
    [self.delegate didReceiveSensorData:sensorData withButtonState:buttonState];
}

- (BOOL)connect
{
    if (![self isConnected]) {
        [self connectToPeripherals];
    }
    return [self isConnected];
}

- (BOOL)disconnect
{
    [self disconnectFromPeripherals];
    return [self isConnected];
}

- (BOOL)startReceivingSensorData
{
    if (![self connect]) {
        NSLog(@"arduino connection manager was unable to connect to arduini !!!");
        return NO;
    }
    return YES;
    /*
    [self connectToPeripherals];
    if ([[BLEDiscovery sharedInstance].connectedPeripherals count] > 0) {
        return YES;
    }
    return NO;*/
}

- (void)stopReceivingSensorData
{
    [NZArduinoCommunicationManager sharedManager].delegate = nil;
    //[self disconnectFromPeripherals];
}

@end
