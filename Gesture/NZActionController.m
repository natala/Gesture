//
//  NZActionController.m
//  Gesture
//
//  Created by Natalia Zarawska on 8/22/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZActionController.h"
#import "NZSingleAction+Execute.h"
#import "NZActionComposite+Execute.h"
#import "NZAction+CoreData.h"
#import "NZAction+Execute.h"

@implementation NZActionController

#pragma mark - singleton
+ (NZActionController *)sharedManager
{
    static NZActionController *sharedManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [NZActionController new];
    });

    return sharedManager;
}

+ (NZActionController *)sharedManagerForGestureSet:(NZGestureSet *)gestureSet
{
    NZActionController *sm = [NZActionController sharedManager];
    sm.currentGestureSet = gestureSet;
    return sm;
}

#pragma mark - init
- (id)init
{
    self = [super init];
    self.observers = [NSMutableArray array];
    return self;
}


-(void)mapAction:(NZAction *)action toGesture:(NZGesture *)gesture
{
    if ([action isKindOfClass:[NZSingleAction class]]) {
        gesture.singleAction = (NZSingleAction *)action;
    } else if ([action isKindOfClass:[NZActionComposite class]]) {
        gesture.actionComposite = (NZActionComposite *)action;
    }
}

-(void)executeGesture:(NZGesture *)gesture withMode:(ExecutionMode)mode
{
    switch (mode) {
        case SINGLE_MODE:
            [gesture.singleAction execute];
            break;
        case GROUP_MODE:
            [gesture.actionComposite execute];
            break;
        default:
            break;
    }
}

- (void)prepareAllActionsForExecution
{
#warning implement the method
    BOOL allActionsReady = true;
    NSArray *allActions = [NZAction findAll];
    for (NZAction *action in allActions) {
        [action prepareForExecution];
    }
    
    if (allActionsReady) {
        for (id<NZActionControllerObserver>observer in self.observers){
            if ([observer respondsToSelector:@selector(didPrepareAllActionsForExecution)]) {
                [observer didPrepareAllActionsForExecution];
            }
        }
    }
}

- (void)disconnectActions
{}

#pragma mark - mnage observers
- (void)addObserver:(id<NZActionControllerObserver>)observer
{
    [self.observers addObject:observer];
}

- (void)removeObserver:(id<NZActionControllerObserver>)observer
{
    [self.observers removeObject:observer];
}


@end
