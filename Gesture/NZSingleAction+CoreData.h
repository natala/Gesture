//
//  NZSingleAction+CoreData.h
//  Gesture
//
//  Created by Natalia Zarawska on 7/1/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZSingleAction.h"

@interface NZSingleAction (CoreData)


+ (NZSingleAction *)create;

+ (NSArray *)findAll;

+ (NSArray *)findAllSortedByName;

+ (NSArray *)findAllSortedByNameActionsForLocation:(NSString *)locationName;

+ (NZSingleAction *)findLates;

- (void)destroy;

+ (void)destroyAll;

@end
