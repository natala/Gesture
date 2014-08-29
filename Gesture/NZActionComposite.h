//
//  NZActionComposite.h
//  Gesture
//
//  Created by Natalia Zarawska on 8/28/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "NZAction.h"

static NSString *ENTITY_NAME_ACTION_COMPOSITE = @"NZActionComposite";

@class NZAction, NZGesture;

@interface NZActionComposite : NZAction

@property (nonatomic, retain) NSSet *childActions;
@property (nonatomic, retain) NSSet *gesture;
@end

@interface NZActionComposite (CoreDataGeneratedAccessors)

- (void)addChildActionsObject:(NZAction *)value;
- (void)removeChildActionsObject:(NZAction *)value;
- (void)addChildActions:(NSSet *)values;
- (void)removeChildActions:(NSSet *)values;

- (void)addGestureObject:(NZGesture *)value;
- (void)removeGestureObject:(NZGesture *)value;
- (void)addGesture:(NSSet *)values;
- (void)removeGesture:(NSSet *)values;

@end
