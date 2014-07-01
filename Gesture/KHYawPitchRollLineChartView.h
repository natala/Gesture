//
//  KHYawPitchRollLineChartView.h
//  KneeHapp
//
//  Created by Pascal Fritzen on 10.05.14.
//  Copyright (c) 2014 Praxis. All rights reserved.
//

#import "KHLineChartView.h"

/**
 * The class KHYawPitchRollLineChartView is a subclass of KHLineChartView and shows the yaw, pitch
 * and roll values over time in a line chart.
 * @author  Pascal Fritzen
 */
@interface KHYawPitchRollLineChartView : KHLineChartView

- (void)setSensorData:(NSArray *)sensorData;

@end
