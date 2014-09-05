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
 * @param selector method to be called
 */
- (void)prepareForExecution:(SEL)selector;

@end
