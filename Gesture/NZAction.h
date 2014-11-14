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

@class NZActionComposite, NZGesture, NZLocation;

@interface NZAction : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *parentAction;
@property (nonatomic, retain) NSSet *gestureSingleReverse;
@property (nonatomic, retain) NSSet *gestureCompositeReverse;

@property (nonatomic, retain) NZLocation *location;



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

- (void)addParentActionObject:(NZActionComposite *)value;
- (void)removeParentActionObject:(NZActionComposite *)value;
- (void)addParentAction:(NSSet *)values;
- (void)removeParentAction:(NSSet *)values;

@end
