//
//  NZGesture+CoreData.h
//  Gesture
//
//  Created by Natalia Zarawska on 7/16/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZGesture.h"

@interface NZGesture (CoreData)


+ (NZGesture *)create;

+ (NSArray *)findAll;

+ (NZGesture *)findLates;

- (void)destroy;

+ (void)destroyAll;

- (NZGesture *)clone;


@end
