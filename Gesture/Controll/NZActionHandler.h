//
//  NZActionHandler.h
//  Gesture
//
//  Created by Natalia Zarawska on 9/5/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NZAction+Execute.h"

@protocol NZActionHandlerObserver <NSObject>

@optional
- (void)actionHandlerDidConnectAction:(NZAction *)action;
- (void)action:(NZAction *)action disconnectedWithErrorMessage:(NSString *)error;
- (void)actionHandlerDidFinishExecutionOfAction:(NZAction *)action;

@end

@interface NZActionHandler : NSObject

@property (nonatomic, retain) NZAction *action;
@property (nonatomic, retain) NSMutableArray *observers;

- (id)initWithAction:(NZAction *)action;

#pragma mark - manage action
- (void)connect;
- (void)execute;

#pragma mark - managing observers
- (void)addObserver:(id<NZActionHandlerObserver>) observer;
- (void)removeObserver:(id<NZActionHandlerObserver>) observer;

@end
