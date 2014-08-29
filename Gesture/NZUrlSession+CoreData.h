//
//  NZUrlSession+CoreData.h
//  Gesture
//
//  Created by Natalia Zarawska on 7/1/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZUrlSession.h"

@interface NZUrlSession (CoreData)


+ (NZUrlSession *)create;

+ (NSArray *)findAll;

+ (NSArray *)findAllSortedByName;

+ (NZUrlSession *)findLates;

- (void)destroy;

+ (void)destroyAll;

@end
