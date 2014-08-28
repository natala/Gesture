//
//  NZSingleAction.h
//  Gesture
//
//  Created by Natalia Zarawska on 8/28/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "NZAction.h"

@class NZGesture;

@interface NZSingleAction : NZAction

@property (nonatomic, retain) NSSet *gesture;
@end

@interface NZSingleAction (CoreDataGeneratedAccessors)

- (void)addGestureObject:(NZGesture *)value;
- (void)removeGestureObject:(NZGesture *)value;
- (void)addGesture:(NSSet *)values;
- (void)removeGesture:(NSSet *)values;

@end
