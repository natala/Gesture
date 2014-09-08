//
//  NZActionHandler.m
//  Gesture
//
//  Created by Natalia Zarawska on 9/5/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZActionHandler.h"

@interface NZActionHandler ()

@end

@implementation NZActionHandler

- (id)init
{
    self = [super init];
    if (self) {
        self.observers = [NSMutableArray array];
    }
    return self;
}

- (id)initWithAction:(NZAction *)action
{
    self = [super init];
    if (self) {
        self.observers = [NSMutableArray array];
        self.action = action;
    }
    return self;
}

#pragma mark - manage action
- (void)execute
{
    [self.action execute];
}

- (void)connect
{
    NSLog(@"nothing to do...");
    [self didConnect];
}

- (void)didConnect
{
    for (id<NZActionHandlerObserver> observer in self.observers) {
        if ([observer respondsToSelector:@selector(actionHandlerDidConnectAction:)]) {
            [observer actionHandlerDidConnectAction:self.action];
        }
    }
}

- (void)didDisconnect
{
    
    for (id<NZActionHandlerObserver> observer in self.observers) {
        if ([observer respondsToSelector:@selector(action:disconnectedWithErrorMessage:)]) {
            [observer action:self.action disconnectedWithErrorMessage:@"disconnected..."];
        }
    }
}

#pragma mark - manage observers
- (void)addObserver:(id<NZActionHandlerObserver>)observer
{
    [self.observers addObject:observer];
}

- (void)removeObserver:(id<NZActionHandlerObserver>)observer
{
    [self.observers removeObject:observer];
}

@end
