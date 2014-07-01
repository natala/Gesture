//
//  KHSensorDataLineChartView.m
//  KneeHapp
//
//  Created by Pascal Fritzen on 10.05.14.
//  Copyright (c) 2014 Praxis. All rights reserved.
//

#import "KHSensorDataLineChartView.h"

@implementation KHSensorDataLineChartView

@synthesize countOfSensorDataToDisplay;

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
//    self.backgroundColor = [UIColor clearColor];
	self.countOfSensorDataToDisplay = -1;
    NSLog(@"Initializing KHSensorDataLineChartView.countOfSensorDataToDisplay: %d", self.countOfSensorDataToDisplay);
}

- (void)setSensorData:(NSArray *)sensorData
{
	if (sensorData && [sensorData count] > 0) {
		// filter the incoming sensor data to |countOfSensorDataToDisplay| objects to be shown in the graph
		if (self.countOfSensorDataToDisplay == -1) {
			// If more than 500 values are displayed the app crashes
			//self.countOfSensorDataToDisplay = 500;
            self.countOfSensorDataToDisplay = 100;
		}

		NSMutableArray *sensorDataToDisplay;

		if (self.countOfSensorDataToDisplay < sensorData.count) {
			sensorDataToDisplay = [NSMutableArray arrayWithCapacity:self.countOfSensorDataToDisplay];

			for (int i = (int)[sensorData count] - self.countOfSensorDataToDisplay; i < sensorData.count; i++) {
				[sensorDataToDisplay addObject:sensorData[i]];
			}
		} else {
			//sensorDataToDisplay = [sensorData mutableCopy];
            sensorDataToDisplay = [NSMutableArray arrayWithArray:sensorData];
		}

		_sensorData = sensorDataToDisplay;

		[self updateChart];
	}
}

- (void)setSpecialSensorData:(NSArray *)specialSensorData
{
	if (specialSensorData && [specialSensorData count] > 0) {
		// filter the incoming sensor data to |countOfSensorDataToDisplay| objects to be shown in the graph
		if (self.countOfSensorDataToDisplay == -1) {
			// If more than 500 values are displayed the app crashes
			self.countOfSensorDataToDisplay = 500;
		}

		NSMutableArray *sensorDataToDisplay;

		if (self.countOfSensorDataToDisplay < specialSensorData.count) {
			sensorDataToDisplay = [NSMutableArray arrayWithCapacity:self.countOfSensorDataToDisplay];

			for (int i = (int)[specialSensorData count] - self.countOfSensorDataToDisplay; i < [specialSensorData count]; i++) {
				[sensorDataToDisplay addObject:specialSensorData[i]];
			}
		} else {
			sensorDataToDisplay = [specialSensorData mutableCopy];
		}

		_specialSensorData = sensorDataToDisplay;

		[self updateChart];
	}
}

- (void)updateChart
{
	// To be overwritten by subclasses
}

@end
