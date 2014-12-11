//
//  NZBeanConnectionManager.m
//  Gesture
//
//  Created by Natalia Zarawska on 12/9/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZBeanConnectionManager.h"

#import "NZSensorData+CoreData.h"
#import "NZQuaternion+CoreData.h"
#import "NZLinearAcceleration+CoreData.h"
#import "NZYawPitchRoll+CoreData.h"
#import "NZGravity+CoreData.h"

@interface NZBeanConnectionManager ()

@property (nonatomic, strong) PTDBean* bean;
@property (nonatomic, strong) PTDBeanManager* beanManager;
@property (nonatomic)  PTDAcceleration acceleration;
@property uint8_t buttonState;

@property BOOL readButtonSignal;
@property BOOL readAccelerationSignal;
@property BOOL tryConnecting;

@end

@implementation NZBeanConnectionManager

#pragma mark - Singleton

+ (NZBeanConnectionManager *)sharedManager
{
    static NZBeanConnectionManager *sharedManager = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedManager = [NZBeanConnectionManager new];
    });
    
    return sharedManager;
}

#pragma mark - Init

- (id)init
{
    self = [super init];
    if (self) {
        self.observers = [[NSMutableArray alloc] init];
        self.beanManager = [[PTDBeanManager alloc] initWithDelegate:self];
        self.readButtonSignal = false;
        self.readAccelerationSignal = false;
        self.tryConnecting = false;
    }
    return self;
}


- (BOOL)isConnected
{
    if (!self.bean) {
        return false;
    }
    return self.bean.state == BeanState_ConnectedAndValidated;
}

- (void)connect
{
    self.tryConnecting = true;
    if (self.bean) {
        [self.beanManager connectToBean:self.bean error:nil];
    }
}

- (void)disconnect
{
    self.tryConnecting = false;
    [self.beanManager disconnectBean:self.bean error:nil];
}

- (BOOL)startListeningToRing
{
    self.readButtonSignal = true;
    if (![self isConnected]) {
        return false;
    }
    [self.bean readScratchBank:2];
    return true;
}

- (void)stopListeningToRing
{
    self.readAccelerationSignal = false;
    self.readButtonSignal = false;
}

- (BOOL)startListeningToAcceleration
{
    self.readAccelerationSignal = true;
    if (![self isConnected] || !self.readButtonSignal) {
        return false;
    }
    [self.bean readAccelerationAxes];
    return true;
}

- (void)stopListeningToAcceleration
{
    self.readAccelerationSignal = false;
}

#pragma mark - PTD Bean Delegate
- (void)bean:(PTDBean *)bean didUpdateAccelerationAxes:(PTDAcceleration)acceleration
{
  /*  NSLog(@"X: %f", acceleration.x);
    NSLog(@"Y: %f", acceleration.y);
    NSLog(@"Z: %f", acceleration.z);
    */
    self.acceleration = acceleration;
    
    if (self.readAccelerationSignal) {
        [self.bean readAccelerationAxes];
    }
}

- (void)bean:(PTDBean *)bean didUpdateScratchBank:(NSInteger)bank data:(NSData *)data
{
    if (bank == 2) {
       // NSLog(@"received data %@", data);
        uint8_t buffer[[data length]];
        [data getBytes:buffer length:[data length]];
        if (self.buttonState != buffer[0]) {
        }
        self.buttonState = buffer[0];
        //if (!self.readAccelerationSignal) {
            [self didReceiveSensorData];
        //}
        if (self.readButtonSignal) {
            [self.bean readScratchBank:2];
        }
    } else {
        NSLog(@"wrong bank");
    }
}

#pragma mark - PTD Bean Manager Delegate
- (void)beanManagerDidUpdateState:(PTDBeanManager *)beanManager
{
    if (self.beanManager.state == BeanManagerState_PoweredOn) {
        [self.beanManager startScanningForBeans_error:nil];
    } else if (self.beanManager.state == BeanManagerState_PoweredOff) {
        NSLog(@"turn on bluetooth!");
    }
}

- (void)beanManager:(PTDBeanManager *)beanManager didConnectBean:(PTDBean *)bean error:(NSError *)error
{
    if (error) {
        NSLog(@"%@", error);
        return;
    }
    
    [self.beanManager stopScanningForBeans_error:&error];
    if (error) {
        NSLog(@"%@", error);
        return;
    }
    
    for (id<NZBeanConnectionManagerObserver> observer in self.observers) {
        if ([observer respondsToSelector:@selector(beanConnectionManagerDidConnected)]) {
            [observer beanConnectionManagerDidConnected];
        }
    }
    
    self.bean = bean;
    self.bean.delegate = self;
    
    if (self.bean.state == BeanState_Discovered) {
        
    }
    else if (self.bean.state == BeanState_ConnectedAndValidated) {
        NSLog(@"Bean Connected and Validated");
        if (self.readButtonSignal) {
            [self startListeningToRing];
        }
        if (self.readAccelerationSignal) {
            [self startListeningToAcceleration];
        }
       // [self.bean readScratchBank:2];
       // [self.bean readAccelerationAxes];
        
    }
}

- (void)beanManager:(PTDBeanManager *)beanManager didDisconnectBean:(PTDBean *)bean error:(NSError *)error
{
    NSLog(@"disconnected form bean %@", bean.name);
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(didDisconnect)]) {
            [self.delegate didDisconnect];
        }
    }
    for (id<NZBeanConnectionManagerObserver> observer in self.observers) {
        if ([observer respondsToSelector:@selector(beanConnectionManagerDidDisconnectConnect)]) {
            [observer beanConnectionManagerDidDisconnectConnect];
        }
    }
    [self.beanManager startScanningForBeans_error:nil];
}

- (void)beanManager:(PTDBeanManager *)beanManager didDiscoverBean:(PTDBean *)bean error:(NSError *)error
{
    NSString *name = bean.name;
    if ([name isEqualToString:@"PowerRing"]) {
        self.bean = bean;
        if (self.tryConnecting) {
            [self.beanManager connectToBean:bean error:nil];
        }
    }
}

- (void)didReceiveSensorData
{
    NZSensorData *sensorData;
    if (!self.readAccelerationSignal) {
        sensorData = nil;
    } else {
        sensorData = [NZSensorData create];
        sensorData.timeStampRecoded = [NSDate date];
        // fill in with dummy data
        NZLinearAcceleration *acc = [NZLinearAcceleration create];
        NSNumber *num = [NSNumber numberWithFloat:0];
        acc.x = [num copy];
        acc.y = [num copy];
        acc.z = [num copy];
        NZYawPitchRoll *ypr = [NZYawPitchRoll create];
        ypr.yaw = [num copy];
        ypr.pitch = [num copy];
        ypr.roll = [num copy];
        NZQuaternion *quat = [NZQuaternion create];
        quat.x = [num copy];
        quat.y = [num copy];
        quat.z = [num copy];
        quat.w = [num copy];
        
        NZGravity *gravity = [NZGravity create];
        gravity.x = [NSNumber numberWithDouble:self.acceleration.x];
        gravity.y = [NSNumber numberWithDouble:self.acceleration.y];
        gravity.z = [NSNumber numberWithDouble:self.acceleration.z];
        
        sensorData.linearAcceleration = acc;
        sensorData.yawPitchRoll = ypr;
        sensorData.quaternion = quat;
        sensorData.gravity = gravity;
    }
    
    // Notify delegate
    [self.delegate didReceiveSensorData:sensorData withButtonState:self.buttonState];
}

/*
 NZSensorData *sensorData = [NZSensorData create];
 sensorData.timeStampRecoded = [NSDate date];
 
 // sensorData = [NSDate date];
 // sensorData.sensorID = [NSNumber numberWithInt:data[14]];
 //  NSLog(@"%d", data[0]);
 uint8_t header = 85;    // 85 == 01010101xb
 uint8_t ending = 170;   // 170 == 10101010xb
 
 if ( (header != data[0]) || (ending != data[16]) ) {
 NSLog(@"received package is incomaptible with the defined ring package");
 return;
 }
 
 int buttonState = data[1];
 //NSLog(@"button: %d", buttonState);
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
 
 // use gravity for row acceleration
 sensorData.gravity.x = [NSNumber numberWithFloat:rawAcceleration.x];
 sensorData.gravity.y = [NSNumber numberWithFloat:rawAcceleration.y];
 sensorData.gravity.z = [NSNumber numberWithFloat:rawAcceleration.z];
 
 
 // NSLog(@"Linear acceleration:  %@, %@, %@", sensorData.linearAcceleration.x, sensorData.linearAcceleration.y, sensorData.linearAcceleration.z);
 
 
 // Notify delegate
 [self.delegate didReceiveSensorData:sensorData withButtonState:buttonState];*/

#pragma mark - setters getters
- (void)setAcceleration:(PTDAcceleration)acceleration
{
    _acceleration = acceleration;
    //if (self.readAccelerationSignal) {
      //  [self didReceiveSensorData];
    //}
}

- (void)setLedColor:(UIColor *)ledColor
{
 
}

#pragma mark - managing observers
- (void)addBeanConnectionObserver:(id<NZBeanConnectionManagerObserver>)observer
{
    if (![self.observers containsObject:observer]) {
        [self.observers addObject:observer];
    }
}

- (void)removeBeanConnectionObserver:(id<NZBeanConnectionManagerObserver>)observer
{
    if ([self.observers containsObject:observer]) {
        [self.observers removeObject:observer];
    }
}


@end
