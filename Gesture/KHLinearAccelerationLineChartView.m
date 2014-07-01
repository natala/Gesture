//
//  KHLinearAccelerationLineChatView.m
//  KneeHapp
//
//  Created by Pascal Fritzen on 06.05.14.
//  Copyright (c) 2014 Praxis. All rights reserved.
//

#import "KHLinearAccelerationLineChartView.h"
#import "KHSensorData+CoreData.h"
#import "KHSensorDataSession+CoreData.h"

#import "KHColorConstants.h"

@interface KHLinearAccelerationLineChartView ()
@property (nonatomic, retain) NSArray *specialData;
@end

@implementation KHLinearAccelerationLineChartView

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
	self.minValue = -20000.0;
	self.maxValue = 20000.0;
	self.interval = 5000.0;
	self.numXIntervals = 10;
	self.yLabelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:0.0f];
	self.xLabelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:0.0f];

//	self.layer.borderColor = kKHColorBlue.CGColor;
//	self.layer.borderWidth = 1.0f;
//	self.layer.cornerRadius = 10.0f;
}

- (void)setSensorData:(NSArray *)sensorData
{
	if ([self sensorData] != sensorData) {
		if (self.countOfSensorDataToDisplay == -1) {
			self.countOfSensorDataToDisplay = 500;
		}

		if (self.countOfSensorDataToDisplay < sensorData.count) {
			NSMutableArray *lastSensorData = [NSMutableArray arrayWithCapacity:self.countOfSensorDataToDisplay];

			for (int i = (int)[sensorData count] - self.countOfSensorDataToDisplay; i < sensorData.count; i++) {
				[lastSensorData addObject:sensorData[i]];
			}

			sensorData = lastSensorData;
		}

		super.sensorData = sensorData;

		[self updateChart];
	}
}

- (void)setSpecialData:(NSArray *)sensorData
{
	_specialData = sensorData;
	[self updateChart];
}

- (void)updateChart
{
	//		NSMutableArray *accelerationXCoordinates = [NSMutableArray arrayWithCapacity:sensorData.count];
	//		NSMutableArray *accelerationYCoordinates = [NSMutableArray arrayWithCapacity:sensorData.count];
	NSMutableArray *accelerationZCoordinates = [NSMutableArray arrayWithCapacity:self.sensorData.count];
	NSMutableArray *xLabels = [NSMutableArray arrayWithCapacity:self.sensorData.count];

	if (self.sensorData.count >= 1) {
		for (int i = 0; i < self.sensorData.count; i++) {
			KHSensorData *singleSensorData = self.sensorData[i];

			if (singleSensorData.linearAcceleration) {
				//					[accelerationXCoordinates addObject:singleSensorData.linearAcceleration.x];
				//					[accelerationYCoordinates addObject:singleSensorData.linearAcceleration.y];
				[accelerationZCoordinates addObject:singleSensorData.linearAcceleration.z];
			}

			//				[xLabels addObject:[NSNumber numberWithInt:[singleSensorData.creationDate timeIntervalSinceDate:startDate]]];
			[xLabels addObject:@""];
		}
	}

	NSArray *points = @[accelerationZCoordinates];

	NSMutableArray *components = [NSMutableArray arrayWithCapacity:1];

	NSArray *titles = @[@""];

	NSArray *colors = @[kKHColorBlue];

	for (int i = 0; i < [points count]; i++) {
		PCLineChartViewComponent *component = [PCLineChartViewComponent new];

		component.title = titles[i];
		component.points = points[i];
		component.colour = colors[i];

		[components addObject:component];
	}

	if (self.specialData) {
		PCLineChartViewComponent *specialPointsLine = [PCLineChartViewComponent new];

		specialPointsLine.title = @"Special";

		NSMutableArray *specialPoints = [NSMutableArray arrayWithCapacity:[self.specialData count]];
		for (KHSensorData *specialSensorData in self.specialData) {
			[specialPoints addObject:specialSensorData.linearAcceleration.z];
		}

		specialPointsLine.points = specialPoints;
		specialPointsLine.colour = PCColorYellow;

		[components addObject:specialPointsLine];
	}

	super.components = components;
	super.xLabels = xLabels;

	[super setNeedsDisplay];
}

@end
