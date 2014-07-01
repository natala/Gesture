//
//  KHLinearAccelerationLineChatView.h
//  KneeHapp
//
//  Created by Pascal Fritzen on 06.05.14.
//  Copyright (c) 2014 Praxis. All rights reserved.
//

#import "KHLineChartView.h"

/**
 * The class KHLinearAccelerationLineChatView is a subclass of KHLineChartView and shows the linear
 * acceleration over time in a line chart.
 * @author  Pascal Fritzen
 */
@interface KHLinearAccelerationLineChartView : KHLineChartView

- (void)setSensorData:(NSArray *)sensorData;
- (void)setSpecialData:(NSArray *)sensorData;

@end
