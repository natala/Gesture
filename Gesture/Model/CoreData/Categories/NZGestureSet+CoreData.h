//
//  NZGestureSet+CoreData.h
//  Gesture
//
//  Created by Natalia Zarawska on 7/16/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZGestureSet.h"

@interface NZGestureSet (CoreData)

+ (NZGestureSet *)create;

+ (NSArray *)findAll;

+ (NZGestureSet *)findLates;

+ (NSArray *)findAllSortetByLabel;

+ (NZGestureSet *)findWithName:(NSString *)name;

- (void)destroy;

+ (void)destroyAll;

- (NZGestureSet *)clone;

- (void)saveToFile;

/**
 * checks if this gesture set contains a gesture with the given class label
 */
- (bool)hasGestureWithLabel:(NSString *)classLabelName;

@end
