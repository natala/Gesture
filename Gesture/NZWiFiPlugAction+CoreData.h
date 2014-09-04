//
//  NZWiFiPlugAction+CoreData.h
//  Gesture
//
//  Created by Natalia Zarawska on 7/1/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZWiFiPlugAction.h"

@interface NZWiFiPlugAction (CoreData)


+ (NZWiFiPlugAction *)create;

+ (NSArray *)findAll;

+ (NSArray *)findAllSortedByName;

+ (NZWiFiPlugAction *)findLates;

- (void)destroy;

+ (void)destroyAll;

@end
