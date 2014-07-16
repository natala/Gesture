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

- (void)destroy;

+ (void)destroyAll;

- (NZGestureSet *)clone;

@end
