//
//  NZBeanConnectionManager.h
//  Gesture
//
//  Created by Natalia Zarawska on 12/9/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PTDBean.h>
#import <PTDBeanManager.h>

@class NZSensorData;

@protocol NZBeanConnectionManagerDelegate <NSObject>

- (void)didReceiveSensorData:(NZSensorData *)sensorData withButtonState:(int)buttonState;

- (void)didDisconnect;

@optional
- (void)connectionState:(NSString *)state;

@end



@protocol NZBeanConnectionManagerObserver <NSObject>

/**
 * called when connection with the external device has been established
 */
- (void)beanConnectionManagerDidConnected;

/**
 * called when the connection with the external device has been lost
 */
- (void)beanConnectionManagerDidDisconnectConnect;

/**
 * called when the manager starts to reconnect automatically
 */
- (void)beanConnectionManagerStartedReconnectiong;

/**
 * called when the manager has stopped the attemped to connect
 */
- (void)beanConnectionManagerStoppedConnecting;

@end




@interface NZBeanConnectionManager : NSObject <PTDBeanDelegate, PTDBeanManagerDelegate>

/**
 * ...
 * @author  Natalia Zarawska
 * @return
 */
+ (NZBeanConnectionManager *)sharedManager;

@property (nonatomic, retain) id<NZBeanConnectionManagerDelegate> delegate;

@property (nonatomic, retain) NSMutableArray *observers;


/**
 * Returns whether the arduino communication manager is able to receive sensor data.
 * @note    This method might be transferred into the KHArduinoCommunicationManagerDelegate protocol.
 * @author  Natalia Zarawska
 * @return  Whether the arduino communication manager is able to receive sensor data.
 */
//- (BOOL)isAbleToReceiveSensorData;

/**
 * Returns if the arduino communication manager is connected to a device
 * @return Whether the arduino communication manager is connected to the arduino
 */
-  (BOOL)isConnected;

/**
 * instructs the arduino communication manager to connect to arduino
 */
- (void)connect;

/**
 * instructs the arduino communication manager to disconnect from the arduino
 * @note
 * @return weather disconnected
 */
- (void)disconnect;

/**
 * Instructs the arduino communication manager to start receiving data from the arduino.
 * @note    Whenever the arduino communication manager receives sensor data he the
 * @c didReceiveSensorData: method on his delegate.
 * @author  Natalia Zarawska
 */
- (BOOL)startListeningToRing;

/**
 * Instructs the arduino communication manager to stop receiving data from the arduino.
 * @author  Natalia Zarawska
 * @note currently this method is not doing anything. Will most probobly be removed soon (if I don't forget :P)
 */
- (void)stopListeningToRing;

- (BOOL)startListeningToAcceleration;

- (void)stopListeningToAcceleration;

#pragma mark - managing observers
- (void)addBeanConnectionObserver:(id<NZBeanConnectionManagerObserver>) observer;

- (void)removeBeanConnectionObserver:(id<NZBeanConnectionManagerObserver>) observer;


@end
