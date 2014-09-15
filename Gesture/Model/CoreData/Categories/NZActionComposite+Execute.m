//
//  NZActionComposite+Execute.m
//  Gesture
//
//  Created by Natalia Zarawska on 8/25/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZActionComposite+Execute.h"

@implementation NZActionComposite (Execute)

- (void)execute
{
    NSLog(@"NZActionComposite - execute()");
    for (NZAction *action in self.childActions) {
        [action execute];
    }
}

- (void)undo
{
    NSLog(@"NZActionComposite - undo()");
    for (NZAction *action in self.childActions) {
        [action undo];
    }
}

@end
