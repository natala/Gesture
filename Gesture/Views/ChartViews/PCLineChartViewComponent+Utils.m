//
//  PCLineChartViewComponent+Utils.m
//  KneeHapp
//
//  Created by Pascal Fritzen on 18.06.14.
//  Copyright (c) 2014 Praxis. All rights reserved.
//

#import "PCLineChartViewComponent+Utils.h"

@implementation PCLineChartViewComponent (Utils)

- (id)initWithTitle:(NSString *)title points:(NSArray *)points color:(UIColor *)color
{
	if (self = [super init]) {
		self.labelFormat = @"%.1f%%";
		self.title = title;
		self.points = points;
		self.colour = color;
	}

	return self;
}

@end
