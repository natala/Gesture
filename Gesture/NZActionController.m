//
//  NZActionController.m
//  Gesture
//
//  Created by Natalia Zarawska on 8/22/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZActionController.h"
#import "NZAction+CoreData.h"
#import "NZHttpRequest+CoreData.h"
#import "NZUrlSession+CoreData.h"
#import "NZActionComposite.h"
#import "NZWiFiPlugAction+CoreData.h"
#import "NZWiFiPlugActionHandler.h"
#import "NZClassLabel.h"

@interface NZActionController ()

@property (nonatomic, retain) NSMutableArray *actionHandlers;
@property (nonatomic, retain) NSMutableDictionary *actionHandlersWithNames;

@end


@implementation NZActionController

int responceCount = 0;

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
    if (self) {
        self.observers = [NSMutableArray array];
      //  self.actionHandlers = [NSMutableArray array];
        self.actionHandlersWithNames = [NSMutableDictionary dictionary];
        [self initateActionHandlers];
    }
    return self;
}

- (void)initateActionHandlers
{
    // initiate action handlers for url actions
    NSArray *urlActions = [NZUrlSession findAll];
    for (NZUrlSession *action in urlActions) {
        NZActionHandler *actionHandler = [[NZActionHandler alloc] initWithAction:(NZAction *)action];
        [actionHandler addObserver:self];
        [self.actionHandlersWithNames setObject:actionHandler forKey:action.name];
        //[self.actionHandlers addObject:actionHandler];
    }
    
    // initiate action handlers for http request actions
    NSArray *httpActions = [NZHttpRequest  findAll];
    for (NZHttpRequest *action in httpActions) {
        NZActionHandler *actionHandler = [[NZActionHandler alloc] initWithAction:(NZAction *)action];
        [actionHandler addObserver:self];
        [self.actionHandlersWithNames setObject:actionHandler forKey:action.name];
    }
    // initiate action handlers for wifi plug actions
    NSArray *wifiPlugActions = [NZWiFiPlugAction findAll];
    for (NZWiFiPlugAction *action in wifiPlugActions) {
        NZActionHandler *actionHandler = [[NZWiFiPlugActionHandler alloc] initWithAction:action];
        [actionHandler addObserver:self];
        [self.actionHandlersWithNames setObject:actionHandler forKey:action.name];
    }
    
    // initiate action handlers for composite actions
    NSArray *compositeActions = [NZActionComposite findAll];
    for (NZActionComposite *action in compositeActions) {
        NZActionHandler *actionHandler = [[NZActionHandler alloc] initWithAction:(NZAction *)action];
        [actionHandler addObserver:self];
        [self.actionHandlersWithNames setObject:actionHandler forKey:action.name];
    }
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
    if (mode == SINGLE_MODE) {
        NZActionHandler *handler = [self.actionHandlersWithNames objectForKey:gesture.singleAction.name];
        [handler execute];
    } else if (mode == GROUP_MODE) {
        NZActionHandler *handler = [self.actionHandlersWithNames objectForKey:gesture.actionComposite.name];
        [handler execute];
    }
}

- (void)prepareAllActionsForExecution
{
    for (NSString *key in self.actionHandlersWithNames) {
        NZActionHandler * handler = [self.actionHandlersWithNames objectForKey:key];
        [handler connect];
    }
}



- (void)disconnectActions
{}

#pragma mark - NZActionHandler Observer methods
- (void)actionHandlerDidConnectAction:(NZAction *)action
{
    responceCount++;
    if (responceCount == [self.actionHandlersWithNames count]) {
        responceCount = 0;
        // notify all observers
        for (id<NZActionControllerObserver>observer in self.observers){
            if ([observer respondsToSelector:@selector(didPrepareAllActionsForExecution)]) {
                [observer didPrepareAllActionsForExecution];
            }
        }

    }
}

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
