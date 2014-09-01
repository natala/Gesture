//
//  NZAction.h
//  Gesture
//
//  Created by Natalia Zarawska on 9/1/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

static NSString *ENTITY_NAME_ACTION = @"NZAction";

@class NZActionComposite, NZGesture;

@interface NZAction : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NZActionComposite *parentAction;
@property (nonatomic, retain) NSSet *gestureSingleReverse;
@property (nonatomic, retain) NSSet *gestureCompositeReverse;
@end

@interface NZAction (CoreDataGeneratedAccessors)

- (void)addGestureSingleReverseObject:(NZGesture *)value;
- (void)removeGestureSingleReverseObject:(NZGesture *)value;
- (void)addGestureSingleReverse:(NSSet *)values;
- (void)removeGestureSingleReverse:(NSSet *)values;

- (void)addGestureCompositeReverseObject:(NZGesture *)value;
- (void)removeGestureCompositeReverseObject:(NZGesture *)value;
- (void)addGestureCompositeReverse:(NSSet *)values;
- (void)removeGestureCompositeReverse:(NSSet *)values;

@end
