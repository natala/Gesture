//
//  NZGestureSet.h
//  Gesture
//
//  Created by Natalia Zarawska on 7/16/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <CoreData/CoreData.h>

static NSString *ENTITY_NAME_GESTURE_SET = @"NZGestureSet";

@interface NZGestureSet : NSManagedObject

#pragma mark - attributes
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * timeStampCreated;
@property (nonatomic, retain) NSDate * timeStampUpdated;

#pragma mark - relationships
@property (nonatomic, retain) NSSet *gestures;
@end

@interface NZGestureSet (CoreDataGeneratedAccessors)

- (void)addGesturesObject:(NSManagedObject *)value;
- (void)removeGesturesObject:(NSManagedObject *)value;
- (void)addGestures:(NSSet *)values;
- (void)removeGestures:(NSSet *)values;

@end

