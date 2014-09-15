//
//  NZAction+Execute.h
//  Gesture
//
//  Created by Natalia Zarawska on 8/25/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NZAction.h"

@interface NZAction (Execute)

/**
 * executes the action
 * @note NZAction is an abstract class, all the subclasses have to override this method
 */
- (void)execute;

/**
 * is called to prepare for executionm, i.e. setup required connection and login
 */
- (void)connect;

/**
 * calls the command set in the undoCommand property
 */
- (void)undo;

@end
