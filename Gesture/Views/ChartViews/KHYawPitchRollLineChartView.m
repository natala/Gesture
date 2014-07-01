//
//  KHYawPitchRollLineChartView.m
//  KneeHapp
//
//  Created by Pascal Fritzen on 10.05.14.
//  Copyright (c) 2014 Praxis. All rights reserved.
//

#import "KHYawPitchRollLineChartView.h"
#import "KHSensorData.h"

@implementation KHYawPitchRollLineChartView

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
	self.minValue = -180;
	self.maxValue = 180;
	self.interval = 30;
	self.numXIntervals = 10;
}

- (void)setSensorData:(NSArray *)sensorData
{
	if (super.sensorData != sensorData) {
		super.sensorData = sensorData;

		if (self.countOfSensorDataToDisplay >= 0 && self.countOfSensorDataToDisplay < sensorData.count) {
			NSMutableArray *lastSensorData = [NSMutableArray arrayWithCapacity:self.countOfSensorDataToDisplay];

			for (int i = (int)[sensorData count] - self.countOfSensorDataToDisplay; i < sensorData.count; i++) {
				[lastSensorData addObject:sensorData[i]];
			}

			sensorData = lastSensorData;
		}

		NSMutableArray *yaw = [NSMutableArray arrayWithCapacity:sensorData.count];
		NSMutableArray *pitch = [NSMutableArray arrayWithCapacity:sensorData.count];
		NSMutableArray *roll = [NSMutableArray arrayWithCapacity:sensorData.count];
		NSMutableArray *xLabels = [NSMutableArray arrayWithCapacity:sensorData.count];

		if (sensorData.count >= 1) {
			NSDate *startDate = ((KHSensorData *)sensorData[0]).creationDate;

			for (int i = 0; i < sensorData.count; i++) {
				KHSensorData *singleSensorData = sensorData[i];

				if (singleSensorData.yawPitchRoll) {
					[yaw addObject:singleSensorData.yawPitchRoll.yaw];
					[pitch addObject:singleSensorData.yawPitchRoll.pitch];
					[roll addObject:singleSensorData.yawPitchRoll.roll];
				}

				[xLabels addObject:[NSNumber numberWithInt:[singleSensorData.creationDate timeIntervalSinceDate:startDate]]];
			}
		}

		NSArray *points = @[yaw, pitch, roll];

		NSMutableArray *components = [NSMutableArray arrayWithCapacity:3];

		NSArray *titles = @[@"YAW", @"PITCH", @"ROLL"];

		NSArray *colors = @[PCColorBlue, PCColorGreen, PCColorRed];

		for (int i = 0; i < 3; i++) {
			PCLineChartViewComponent *component = [PCLineChartViewComponent new];

			component.title = titles[i];
			component.points = points[i];
			component.colour = colors[i];

			[components addObject:component];
		}

		super.components = components;
		super.xLabels = xLabels;

		[super setNeedsDisplay];
	}
}

@end
