//
//  NZActionComposite.h
//  Gesture
//
//  Created by Natalia Zarawska on 8/22/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NZGesture;

static NSString *ENTITY_NAME_ACTION_COMPOSITE = @"NZActionComposite";

@interface NZActionComposite : NSManagedObject

@property (nonatomic, retain) NSSet *actions;
@property (nonatomic, retain) NSSet *gesture;

@end

@interface NZActionComposite (CoreDataGeneratedAccessors)

- (void)addActionsObject:(NSManagedObject *)value;
- (void)removeActionsObject:(NSManagedObject *)value;
- (void)addActions:(NSSet *)values;
- (void)removeActions:(NSSet *)values;

- (void)addGestureObject:(NZGesture *)value;
- (void)removeGestureObject:(NZGesture *)value;
- (void)addGesture:(NSSet *)values;
- (void)removeGesture:(NSSet *)values;

@end
