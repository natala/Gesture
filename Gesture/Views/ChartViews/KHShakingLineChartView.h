//
//  KHShakingLineChartView.h
//  KneeHapp
//
//  Created by Pascal Fritzen on 20.06.14.
//  Copyright (c) 2014 Praxis. All rights reserved.
//

#import "PCLineChartView.h"
#import "PCLineChartViewComponent+Utils.h"

/**
 * The class KHShakingLineChartView is a wrapper for PCLineChartView and basically contains
 * properties (e.g. values) for utility reasons.
 */
@interface KHShakingLineChartView : PCLineChartView

/**
 * The values to be displayed in the chart.
 * @author  Pascal Fritzen
 */
@property (nonatomic, retain) NSArray *values;

@property (nonatomic) int countOfValuesToDisplay;

- (void)commonInit;

@end
