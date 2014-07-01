//
//  NZSensorDataTableView.m
//  Gesture
//
//  Created by Natalia Zarawska on 6/30/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZSensorDataTableView.h"

@implementation NZSensorDataTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath
{
    return [super dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
