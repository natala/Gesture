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

typedef enum executionMode {
    SINGLE_MODE,
    GROUP_MODE
} ExecutionMode;

@interface NZActionController : NSObject

/**
 * Create and return the singleton instance of the action controller
 */
+ (NZActionController *) sharedManager;

+ (NZActionController *) sharedManagerForGestureSet:(NZGestureSet *)gestureSet;

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
- (void)executeGesture:(NZGesture *)gesture withMode:(ExecutionMode)mode;

@end
