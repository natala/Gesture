//
//  NZAction+Execute.m
//  Gesture
//
//  Created by Natalia Zarawska on 8/25/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZAction+Execute.h"

@implementation NZAction (Execute)

- (void)execute
{
    // NZAction is an abstract class
    NSLog(@"NZAction is an abstract class. The method execute() should be implemented by all the subclasses!");
}

- (void)connect
{
    // NZAction is an abstract class
    NSLog(@"NZAction is an abstract class. The method prepareForExecution() should be implemented by all the subclasses!");
}

@end
