//
//  NZSingleAction.h
//  Gesture
//
//  Created by Natalia Zarawska on 8/22/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NZGesture;

static NSString *ENTITY_NAME_SINGLE_ACTION = @"NZSingleAction";

@interface NZSingleAction : NSManagedObject

@property (nonatomic, retain) NSSet *gesture;

@end

@interface NZSingleAction (CoreDataGeneratedAccessors)

- (void)addGestureObject:(NZGesture *)value;
- (void)removeGestureObject:(NZGesture *)value;
- (void)addGesture:(NSSet *)values;
- (void)removeGesture:(NSSet *)values;


@end
