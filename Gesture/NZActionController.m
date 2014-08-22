//
//  NZActionController.m
//  Gesture
//
//  Created by Natalia Zarawska on 8/22/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZActionController.h"
#import "NZActionComposite+CoreData.h"
#import "NZSingleAction+CoreData.h"

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
#warning implement the method execute() for the actions
    
    switch (mode) {
        case SINGLE_MODE:
            
            break;
        case GROUP_MODE:
            break;
        default:
            break;
    }
}

- (NSArray *)allCompositeActions
{
    return [NZActionComposite findAll];
}

- (NSArray *)allSingleActions
{
    return [NZSingleAction findAll];
}

@end
