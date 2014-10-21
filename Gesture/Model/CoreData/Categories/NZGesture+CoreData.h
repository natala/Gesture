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

+ (NSArray *)findAllSortetByLabel;

+ (NZGesture *)findLates;

+ (NZGesture *)findGestureWithIndex:(NSNumber *)index;

+ (NZGesture *)findGestureWithLabel:(NZClassLabel *)label;

- (void)destroy;

+ (void)destroyAll;

- (NZGesture *)clone;

#pragma mark - additional not really related with core data itself
/**
 * saves to a csv file with the name of the given gesture
 */
- (void)saveToFile;


@end
