//
//  NZActionController.h
//  Gesture
//
//  Created by Natalia Zarawska on 8/22/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NZAction.h"
#import "NZGesture+CoreData.h"
#import "NZGestureSet.h"
#import "NZActionHandler.h"

typedef enum executionMode {
    SINGLE_MODE,
    GROUP_MODE
} ExecutionMode;

@protocol NZActionControllerObserver <NSObject>

@optional
/**
 * thi method is called when the Controller has set up all the connections
 * such as login to the WiFiPlug server
 */
- (void)didPrepareAllActionsForExecution;

/**
 * called when the action has been executed succesfully
 * @param action the action that has been executed
 */
- (void)didExecuteAction:(NZAction *)action;

/**
 * called when failed to execute action
 * @param action the action that failed to be executed
 * @param errorMessage message descraibing what fialed
 */
- (void)didFailToExecuteAction:(NZAction *)action withErrorMessage:(NSString *)errorMessage;

/**
 * called after executing action
 * @param action that had been executed
 * @param errorMessage if there was an error executing, contains the error message
 */
- (void)didExecuteAction:(NZAction *)action withErrorMessage:(NSString *)errorMessage;

/**
 * if connection has been losed for one of the actions
 * @param action the action for which the connection has been loset
 * @note method is epsecially for the NZWiFiPlugAction since the connection is very unstable
 */
- (void)didLooseConnectionForAction:(NZAction *)action;

@end

@interface NZActionController : NSObject <NZActionHandlerObserver>

/**
 * Create and return the singleton instance of the action controller
 */
+ (NZActionController *) sharedManager;

+ (NZActionController *) sharedManagerForGestureSet:(NZGestureSet *)gestureSet;

@property (nonatomic, retain) NSMutableArray * observers;

@property (nonatomic, retain) NZGestureSet *currentGestureSet;

/**
 * maps the given action to the gesture
 * @note the gesture can have only one single actiona and one action composite. If there is one already mapped, it will be replaced with the new one.
 * @param action can be wheather a SingleAction or an ActionComposite
 * @param the gesture to which to map the gesture
 */
- (void)mapAction:(NZAction *)action toGesture:(NZGesture *)gesture;

/**
 * executes the actions mapped to the gesture
 * @param gesture the gesture that triggers the action
 * @param mode the mode in which the execution is triggered. Possible is ExecutionMode::SINGLE_MODE or ::GROUP_MODE. The group mode will trigger the action composite and single mode the single action
 */
- (void)executeGesture:(NZGesture *)gesture withMode:(ExecutionMode)mode forLocation:(NSString *) locationName;

/**
 * undo the execution of the last gesture. 
 * @note executes the last action with its defined undoCommand. If not defined, nothing happens
 */
- (void)undoLastExecution;

/**
 * sets up all required connections and logins
 */
- (void)prepareAllActionsForExecution;

/**
 * disconnects all the connections
 * @note for example the WiFiPlug connections
 */

- (void)disconnectActions;

#pragma mark - manage observers
- (void)addObserver:(id<NZActionControllerObserver>) observer;
- (void)removeObserver:(id<NZActionControllerObserver>) observer;

@end
