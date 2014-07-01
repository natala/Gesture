//
//  NZArduinoCommunicationManager.h
//  Gest
//
//  Created by Natalia Zarawska on 6/26/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NZSensorDataObject.h"
#import "BLE/BLEDiscovery.h"

@protocol NZArduinoCommunicationManagerDelegate <NSObject>
//#import "KHSensorData+CoreData.h"


/**
 * This method is called whenever the arduino communication manager has received and converted data
 * from the arduino into meaningful sensor data.
 * @author  Pascal Fritzen
 * @param   sensorData   The converted sensor data from the arduino.
 */
- (void)didReceiveSensorData:(NZSensorDataObject *)sensorData;

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
 * Instructs the arduino communication manager to start receiving data from the arduino.
 * @note    Whenever the arduino communication manager receives sensor data he the
 * @c didReceiveSensorData: method on his delegate.
 * @author  Pascal Fritzen
 */
- (void)startReceivingSensorData;

/**
 * Instructs the arduino communication manager to stop receiving data from the arduino.
 * @author  Pascal Fritzen
 */
- (void)stopReceivingSensorData;

@end
