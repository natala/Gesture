//
//  NZHttpRequest+CoreData.h
//  Gesture
//
//  Created by Natalia Zarawska on 7/1/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZHttpRequest.h"

@interface NZHttpRequest (CoreData)


+ (NZHttpRequest *)create;

+ (NSArray *)findAll;

+ (NSArray *)findAllSortedByName;

+ (NZHttpRequest *)findLates;

- (void)destroy;

+ (void)destroyAll;

@end
