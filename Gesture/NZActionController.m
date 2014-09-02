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

@end
