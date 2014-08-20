//
//  NZArduinoCommunicationManager.h
//  Gest
//
//  Created by Natalia Zarawska on 6/26/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NZSensorData.h"
#import "BLE/BLEDiscovery.h"

@protocol NZArduinoCommunicationManagerDelegate <NSObject>
//#import "KHSensorData+CoreData.h"


/**
 * This method is called whenever the arduino communication manager has received and converted data
 * from the arduino into meaningful sensor data.
 * @author  Pascal Fritzen
 * @param   sensorData   The converted sensor data from the arduino.
 */
- (void)didReceiveSensorData:(NZSensorData *)sensorData withButtonState:(int)buttonState;

@optional
- (void)connectionState:(NSString *)state;

@end

@interface NZArduinoCommunicationManager : NSObject <BLEDiscoveryDelegate, BLEServiceDataDelegate, BLEServiceDelegate>

/**
 * Creates and returns the singleton instance of the arduino communication manager.
 * @author  Pascal Fritzen
 * @return  The singleton instance of the feature extraction manager.
 */
+ (NZArduinoCommunicationManager *)sharedManager;

@property (nonatomic, retain) id<NZArduinoCommunicationManagerDelegate> delegate;


/**
 * Returns whether the arduino communication manager is able to receive sensor data.
 * @note    This method might be transferred into the KHArduinoCommunicationManagerDelegate protocol.
 * @author  Pascal Fritzen
 * @return  Whether the arduino communication manager is able to receive sensor data.
 */
- (BOOL)isAbleToReceiveSensorData;

/**
 * Returns if the arduino communication manager is connected to a device
 * @return Whether the arduino communication manager is connected to the arduino
 */
-  (BOOL)isConnected;

/**
 * instructs the arduino communication manager to connect to arduino
 * @return weather the was able to connect
 */
- (BOOL)connect;

/**
 * instructs the arduino communication manager to disconnect from the arduino
 * @note
 * @return weather disconnected
 */
- (BOOL)disconnect;

/**
 * Instructs the arduino communication manager to start receiving data from the arduino.
 * @note    Whenever the arduino communication manager receives sensor data he the
 * @c didReceiveSensorData: method on his delegate.
 * @author  Pascal Fritzen
 */
- (BOOL)startReceivingSensorData;

/**
 * Instructs the arduino communication manager to stop receiving data from the arduino.
 * @author  Pascal Fritzen
 * @note currently this method is not doing anything. Will most probobly be removed soon (if I don't forget :P)
 */
- (void)stopReceivingSensorData;

@end
