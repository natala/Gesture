//
//  NZSingleAction.h
//  Gesture
//
//  Created by Natalia Zarawska on 9/1/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "NZAction.h"

static NSString *ENTITY_NAME_SINGLE_ACTION = @"NZSingleAction";


@interface NZSingleAction : NZAction

@property (nonatomic, retain) NSString * undoCommand;

@end
