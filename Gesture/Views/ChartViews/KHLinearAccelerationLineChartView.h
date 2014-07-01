//
//  KHLinearAccelerationLineChatView.h
//  KneeHapp
//
//  Created by Pascal Fritzen on 06.05.14.
//  Copyright (c) 2014 Praxis. All rights reserved.
//

#import "KHSensorDataLineChartView.h"



/**
 * The class KHLinearAccelerationLineChatView is a subclass of KHSensorDataLineChartView and shows the linear
 * acceleration over time in a line chart.
 * @author  Pascal Fritzen
 */
@interface KHLinearAccelerationLineChartView : KHSensorDataLineChartView

- (void)setSensorData:(NSArray *)sensorData;

@end
