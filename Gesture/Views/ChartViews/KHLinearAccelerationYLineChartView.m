//
//  KHLinearAccelerationLineChatView.m
//  KneeHapp
//
//  Created by Pascal Fritzen on 06.05.14.
//  Copyright (c) 2014 Praxis. All rights reserved.
//

#import "KHLinearAccelerationYLineChartView.h"
#import "KHSensorData.h"
#import "PCLineChartViewComponent+Utils.h"

@implementation KHLinearAccelerationYLineChartView

- (void)commonInit
{
	[super commonInit];

	super.minValue = -11000.0;
	super.maxValue = 11000.0;
	super.interval = 10000.0;
	super.numXIntervals = 10;
	super.yLabelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.0f];
	super.xLabelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.0f];
}

- (void)updateChart
{
	if (!((KHSensorData *)super.sensorData[0]).linearAcceleration) {
		return;
	}

	float numberOfSmoothing = 1.0f;

	if ([super.sensorData count] < numberOfSmoothing) {
		return;
	}

	NSMutableArray *yAccelerationPoints = [NSMutableArray arrayWithCapacity:[super.sensorData count]];
	NSMutableArray *specialYAccelerationPoints = [NSMutableArray arrayWithCapacity:[super.sensorData count]];
	NSMutableArray *xLabels = [NSMutableArray arrayWithCapacity:[super.sensorData count]];

	for (int i = 0; i < numberOfSmoothing; i++) {
		[yAccelerationPoints addObject:((KHSensorData *)super.sensorData[i]).linearAcceleration.y];
		[specialYAccelerationPoints addObject:@0];
	}

	for (int i = numberOfSmoothing; i < [super.sensorData count]; i++) {
		double sum = 0.0f;
		for (int j = i - numberOfSmoothing; j < i; j++) {
			sum += [((KHSensorData *)super.sensorData[j]).linearAcceleration.y floatValue];
		}

		sum /= numberOfSmoothing;
		[yAccelerationPoints addObject:[NSNumber numberWithDouble:sum]];

		BOOL isSpecial = NO;
		KHSensorData *specialSensorDataObject;
		for (KHSensorData *specialSensorData in super.specialSensorData) {
			if (super.sensorData[i] == specialSensorData) {
				isSpecial = YES;
				specialSensorDataObject = specialSensorData;
				break;
			}
		}

		[specialYAccelerationPoints addObject:isSpecial ? specialSensorDataObject.linearAcceleration.y:@0];

		[xLabels addObject:@""];
	}

	PCLineChartViewComponent *yAcceleration = [[PCLineChartViewComponent alloc] initWithTitle:@""
																					   points:yAccelerationPoints
																						color:kKHColorBlue];

	PCLineChartViewComponent *specialYAcceleration = [[PCLineChartViewComponent alloc] initWithTitle:@"Special"
																							  points:specialYAccelerationPoints
																							   color:PCColorOrange];

	super.components = [NSMutableArray array];
	if ([super.specialSensorData count] > 0) {
		[super.components addObject:specialYAcceleration];
	}
	[self.components addObject:yAcceleration];
	super.xLabels = xLabels;

	[super setNeedsDisplay];
}

@end
