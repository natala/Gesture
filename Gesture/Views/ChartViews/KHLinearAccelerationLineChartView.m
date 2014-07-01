//
//  KHLinearAccelerationLineChatView.m
//  KneeHapp
//
//  Created by Pascal Fritzen on 06.05.14.
//  Copyright (c) 2014 Praxis. All rights reserved.
//

#import "KHLinearAccelerationLineChartView.h"
#import "NZSensorData+CoreData.h"
#import "NZSensorDataSet+CoreData.h"
#import "NZLinearAcceleration+CoreData.h"
#import "NZCoreDataManager.h"
#import "NZCoreDataManager.h"


#define UIColorFromHex(hex) [UIColor colorWithRed : ((float)((hex & 0xFF0000) >> 16)) / 255.0 green : ((float)((hex & 0xFF00) >> 8)) / 255.0 blue : ((float)(hex & 0xFF)) / 255.0 alpha : 1.0]

#define kKHColorBlue           UIColorFromHex(0x007AFF)
//  [UIColor colorWithRed:0.0 / 255.0 green:122.0 / 255.0 blue:255.0 / 255.0 alpha:1]
#define kKHColorGreyBackground UIColorFromHex(0xD8D8D8)
//  [UIColor colorWithRed:247.0 / 255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1]
#define kKHColorGreyIcon       UIColorFromHex(0x9B9B9B)
//  [UIColor colorWithRed:155.0 / 255.0 green:155.0 / 255.0 blue:155.0 / 255.0 alpha:1]
#define kKHColorGreyMenu       UIColorFromHex(0xE6E4E4)
//  [UIColor colorWithRed:(230.0 / 255.0) green:(228.0 / 255.0) blue:(228.0 / 255.0) alpha:1.0]

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
    [super commonInit];
	self.minValue = -20000.0;
	self.maxValue = 20000.0;
	self.interval = 5000.0;
	self.numXIntervals = 30;
    //self.numYIntervals = 10;
	//**self.yLabelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:0.0f];
	//**self.xLabelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:0.0f];

//	self.layer.borderColor = kKHColorBlue.CGColor;
//	self.layer.borderWidth = 1.0f;
//	self.layer.cornerRadius = 10.0f;
}

- (void)setSensorData:(NSArray *)sensorData
{
/**	if ([self sensorData] != sensorData) {
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
 */
    
    if (super.sensorData != sensorData) {
        super.sensorData = sensorData;
        
        if (self.countOfSensorDataToDisplay >= 0 && self.countOfSensorDataToDisplay < sensorData.count) {
            NSMutableArray *lastSensorData = [NSMutableArray arrayWithCapacity:self.countOfSensorDataToDisplay];
            
            for (int i = (int)[sensorData count] - self.countOfSensorDataToDisplay; i < sensorData.count; i++) {
                [lastSensorData addObject:sensorData[i]];
            }
            
            sensorData = lastSensorData;
        }
        
        NSMutableArray *x = [NSMutableArray arrayWithCapacity:sensorData.count];
        NSMutableArray *y = [NSMutableArray arrayWithCapacity:sensorData.count];
        NSMutableArray *z = [NSMutableArray arrayWithCapacity:sensorData.count];
        NSMutableArray *xLabels = [NSMutableArray arrayWithCapacity:sensorData.count];
        
        if (sensorData.count >= 1) {
            //NSDate *startDate = ((NZSensorData *)sensorData[0]).creationDate;
            
            for (int i = 0; i < sensorData.count; i++) {
                //NZSensorData *singleSensorData = [[[NZCoreDataManager sharedManager] managedObjectContext] objectRegisteredForID:sensorDataIDs[i]];
                NZSensorData *singleSensorData = sensorData[i];
                
                if (singleSensorData.linearAcceleration) {
                    [x addObject:singleSensorData.linearAcceleration.x];
                    [y addObject:singleSensorData.linearAcceleration.y];
                    [z addObject:singleSensorData.linearAcceleration.z];
                }
                
                //[xLabels addObject:[NSNumber numberWithInt:[singleSensorData.creationDate timeIntervalSinceDate:startDate]]];
                [xLabels addObject:[NSNumber numberWithInt:i]];
            }
        }
        
        NSArray *points = @[x, y, z];
        
        NSMutableArray *components = [NSMutableArray arrayWithCapacity:3];
        
        NSArray *titles = @[@"X", @"Y", @"Z"];
        
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

- (void)updateChart
{
	//		NSMutableArray *accelerationXCoordinates = [NSMutableArray arrayWithCapacity:sensorData.count];
	//		NSMutableArray *accelerationYCoordinates = [NSMutableArray arrayWithCapacity:sensorData.count];
	//NSMutableArray *accelerationZCoordinates = [NSMutableArray arrayWithCapacity:self.sensorData.count];
    NSMutableArray *accelerationZCoordinates = [NSMutableArray arrayWithCapacity:self.sensorData.count];
	//NSMutableArray *xLabels = [NSMutableArray arrayWithCapacity:self.sensorData.count];
    NSMutableArray *xLabels = [NSMutableArray arrayWithCapacity:self.sensorData.count];
    
	if (self.sensorData.count >= 1) {
		for (int i = 0; i < self.sensorData.count; i++) {
        
            NSManagedObjectContext *context = [[NZCoreDataManager sharedManager] managedObjectContext];
            
			NZSensorData *singleSensorData = [self.sensorData objectAtIndex:i];
            
            //NZSensorData *singleSensorData = [context objectRegisteredForID:self.sensorDataIDs[i]];

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
		for (NZSensorData *specialSensorData in self.specialData) {
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
