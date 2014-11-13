//
//  NZLocation+CoreData.h
//  Gesture
//
//  Created by Natalia Zarawska on 11/13/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "NZLocation.h"

@interface NZLocation (CoreData)


+ (NZLocation *)create;

+ (NSArray *)findAll;

+ (NSArray *)findAllSortedByName;

/**
 * returns the instance of the "global location"
 */
+ (NZLocation *)globalLocation;

/**
 * checks if there is already an action (singl or group) with the given name
 */
+ (BOOL)existsWithName:(NSString *)name;

- (void)destroy;

+ (void)destroyAll;

@end
