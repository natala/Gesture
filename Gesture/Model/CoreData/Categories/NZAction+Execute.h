//
//  NZAction+Execute.h
//  Gesture
//
//  Created by Natalia Zarawska on 8/22/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NZAction.h"

@interface NZAction (Execute)

/**
 * execute the action
 @note has to be overriten by all subclasses
 */
- (void)execute;

@end
