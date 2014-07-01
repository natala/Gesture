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
#import "NZQuaternionObject.h"
#import "NZLinearAccelerationObject.h"
#import "NZSensorDataObject.h"
#import "NZGravityObject.h"
#import "NZYawPitchRollObject.h"

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
    return [BLEDiscovery sharedInstance].foundPeripherals.count == 1;
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
    // Linear Acceleration
    int linAccelX = (short)((data[0] << 8) | data[1]);
    int linAccelY = (short)((data[2] << 8) | data[3]);
    int linAccelZ = (short)((data[4] << 8) | data[5]);
    
    // Quaternions
    float q[] = { 0, 0, 0, 0 };
    
    q[0] = ((data[6] << 8) | data[7]) / 16384.0f;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 // dividing by 16384.0f should be the same as >> 14 ?
    q[1] = ((data[8] << 8) | data[9]) / 16384.0f;
    q[2] = ((data[10] << 8) | data[11]) / 16384.0f;
    q[3] = ((data[12] << 8) | data[13]) / 16384.0f;
    
    for (int i = 0; i < 4; i++) {
        if (q[i] >= 2) {
            q[i] = -4 + q[i];
        }
    }
    
    GLKQuaternion quat = GLKQuaternionMake(q[0], q[1], q[2], q[3]);
    GLKVector3 axisRotation = GLKQuaternionAxis(quat);
    // float angel = GLKQuaternionAngle(quat);
    // NSLog(@"Current Angel: %f", angel * M_PI/180);
    
    // Euler Angles
    /*
     *  float euler[] = { 0, 0, 0 };
     *  euler[0] = atan2(2 * q[1] * q[2] - 2 * q[0] * q[3], 2 * q[0] * q[0] + 2 * q[1] * q[1] - 1);
     *  euler[1] = -asin(2 * q[1] * q[3] + 2 * q[0] * q[2]);
     *  euler[2] = atan2(2 * q[2] * q[3] - 2 * q[0] * q[1], 2 * q[0] * q[0] + 2 * q[3] * q[3] - 1);
     */
    // Gravity
    float gravity[] = { 0, 0, 0 };
    gravity[0] = 2 * (q[1] * q[3] - q[0] * q[2]);
    gravity[1] = 2 * (q[0] * q[1] + q[2] * q[3]);
    gravity[2] = q[0] * q[0] - q[1] * q[1] - q[2] * q[2] + q[3] * q[3];
    
    // Yaw, Pitch and Roll
    float ypr[] = { 0, 0, 0 };
    // ypr[0] = atan2(2 * quat.y * quat.w - 2 * quat.x * quat.z, 1 - 2 * quat.y * quat.y - 2 * quat.z * quat.z);
    ypr[0] = atan2(2 * q[1] * q[2] - 2 * q[0] * q[3], 2 * q[0] * q[0] + 2 * q[1] * q[1] - 1);
    
    // ypr[1] = atan2(2 * quat.x * quat.w - 2 * quat.y * quat.z, 1 - 2 * quat.x * quat.x - 2 * quat.z * quat.z);
    ypr[1] = atan(gravity[0] / sqrt(gravity[1] * gravity[1] + gravity[2] * gravity[2]));
    
    // ypr[2] = sin(2 * quat.x * quat.y + 2 * quat.z * quat.w);
    ypr[2] = atan(gravity[1] / sqrt(gravity[0] * gravity[0] + gravity[2] * gravity[2]));
    
    
    // NSLog(@"Current Euler angels: %f,%f,%f",  euler[0] * 180 / M_PI, euler[1] * 180 / M_PI, euler[2] * 180 / M_PI);
    // NSLog(@"Current Yaw Pitch and Roll: %f,%f,%f",  ypr[0] * 180 / M_PI, ypr[1] * 180 / M_PI, ypr[2] * 180 / M_PI);
    // if (data[14] == 1) {
    //	NSLog(@"Current Yaw Pitch and Roll: %f,%f,%f",  ypr[0] * 180 / M_PI, ypr[1] * 180 / M_PI, ypr[2] * 180 / M_PI);
    
    // NSLog(@"Current Axis rotation: %f,%f,%f", axisRotation.x * 180 / M_PI, axisRotation.y * 180 / M_PI, axisRotation.z * 180 / M_PI);
    // }
   
    // KHLinearAcceleration *linearAcceleration = [KHLinearAcceleration create];
    NZLinearAccelerationObject *linearAcceleration = [[NZLinearAccelerationObject alloc] init];
    linearAcceleration.x = [NSNumber numberWithInt:linAccelX];
    linearAcceleration.y = [NSNumber numberWithInt:linAccelY];
    linearAcceleration.z = [NSNumber numberWithInt:linAccelZ];
    
    //KHQuaternion *quaternion = [KHQuaternion create];
    NZQuaternionObject *quaternion = [[NZQuaternionObject alloc] init];
    quaternion.q0 = [NSNumber numberWithFloat:q[0]];
    quaternion.q1 = [NSNumber numberWithFloat:q[1]];
    quaternion.q2 = [NSNumber numberWithFloat:q[2]];
    quaternion.q3 = [NSNumber numberWithFloat:q[3]];
    
    //KHGravity *gravityXYZ = [KHGravity create];
    NZGravityObject *gravityXYZ = [[NZGravityObject alloc] init];
    gravityXYZ.x = [NSNumber numberWithFloat:gravity[0]];
    gravityXYZ.y = [NSNumber numberWithFloat:gravity[1]];
    gravityXYZ.z = [NSNumber numberWithFloat:gravity[2]];
    
//    KHYawPitchRoll *yawPitchRoll = [KHYawPitchRoll create];
    NZYawPitchRollObject *yawPitchRoll = [[NZYawPitchRollObject alloc] init];
    yawPitchRoll.yaw    = [NSNumber numberWithFloat:ypr[0] * 180.0 / M_PI];
    yawPitchRoll.pitch  = [NSNumber numberWithFloat:ypr[1] * 180.0 / M_PI];
    yawPitchRoll.roll   = [NSNumber numberWithFloat:ypr[2] * 180.0 / M_PI];
    
    //KHSensorData *sensorData = [KHSensorData create];
    NZSensorDataObject *sensorData = [[NZSensorDataObject alloc] init];
    sensorData.linearAcceleration = linearAcceleration;
    sensorData.quaternion = quaternion;
    sensorData.gravity = gravityXYZ;
    sensorData.yawPitchRoll = yawPitchRoll;
    
    //sensorData.creationDate = [NSDate date];
    //sensorData.sensorID = [NSNumber numberWithInt:data[14]];
    
    [self.delegate didReceiveSensorData:sensorData];
}

- (void)startReceivingSensorData
{
    [self connectToPeripherals];
}

- (void)stopReceivingSensorData
{
    [self disconnectFromPeripherals];
}

@end
