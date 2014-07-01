//
//  KHSensorDataLineChartView.m
//  KneeHapp
//
//  Created by Pascal Fritzen on 10.05.14.
//  Copyright (c) 2014 Praxis. All rights reserved.
//

#import "KHShakingLineChartView.h"

@implementation KHShakingLineChartView

- (id)initWithCoder:(NSCoder *)coder
{
	self = [super initWithCoder:coder];
	if (self) {
		[self commonInit];
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self commonInit];
	}
	return self;
}

- (void)commonInit
{
	self.countOfValuesToDisplay = -1;

	super.minValue = 0.0;
	super.maxValue = 2000.0;
	super.interval = 1000.0;
	super.numXIntervals = 10;
	super.yLabelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f];
	super.xLabelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f];
}

- (void)setValues:(NSArray *)values
{
	if (values && [values count] > 0) {

		// filter the incoming sensor data to |countOfSensorDataToDisplay| objects to be shown in the graph
		if (self.countOfValuesToDisplay == -1) {
			// If more than 500 values are displayed the app crashes
			self.countOfValuesToDisplay = 500;
		}

		NSMutableArray *valuesToDisplay;

		if (self.countOfValuesToDisplay < [values count]) {
			valuesToDisplay = [NSMutableArray arrayWithCapacity:self.countOfValuesToDisplay];

			for (int i = (int)[values count] - self.countOfValuesToDisplay; i < [values count]; i++) {
				[valuesToDisplay addObject:values[i]];
			}
		} else {
			valuesToDisplay = [values mutableCopy];
		}

		_values = valuesToDisplay;

		[self updateChart];
	}
}

- (void)updateChart
{
	if (!self.values) {
		return;
	}

	NSMutableArray *xLabels = [NSMutableArray arrayWithCapacity:[self.values count]];

	for (NSNumber *value in self.values) {
		[xLabels addObject:@""];
	}

	PCLineChartViewComponent *component = [[PCLineChartViewComponent alloc] initWithTitle:@""
																				   points:self.values
																					color:kKHColorBlue];

	super.components = [NSMutableArray arrayWithObject:component];
	super.xLabels = xLabels;

	[super setNeedsDisplay];
}

@end
