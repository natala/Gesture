//
//  NZAction+CoreData.h
//  Gesture
//
//  Created by Natalia Zarawska on 8/25/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NZAction.h"


@interface NZAction (CoreData)

+ (NZAction *)create;

+ (NSArray *)findAll;

+ (NSArray *)findAllSortedByName;

+ (NZAction *)findLates;

/**
 * checks if there is already an action (singl or group) with the given name
 */
+ (BOOL)existsWithName:(NSString *)name;

- (void)destroy;

+ (void)destroyAll;


@end
