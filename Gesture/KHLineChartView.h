//
//  KHLineChartView.h
//  KneeHapp
//
//  Created by Pascal Fritzen on 10.05.14.
//  Copyright (c) 2014 Praxis. All rights reserved.
//

#import "PCLineChartView.h"

/**
 * The @b abstract class KHLineChartView is a wrapper for PCLineChartView and basically contains
 * properties (e.g. sensorData) and helper methods which are used by all subclasses.
 */
@interface KHLineChartView : PCLineChartView

/**
 * The sensor data to be displayed in the chart.
 * @note    Subclasses should overwrite the @c-setSensorData:(NSArray *)@c sensorData method to update
 * the view according to the new sensor data.
 * @author  Pascal Fritzen
 */
@property (nonatomic, retain) NSArray *sensorData;

@property (nonatomic) int countOfSensorDataToDisplay;

@end
