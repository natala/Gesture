//
//  NZActionComposite+CoreData.h
//  Gesture
//
//  Created by Natalia Zarawska on 7/16/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZActionComposite.h"

@interface NZActionComposite (CoreData)

+ (NZActionComposite *)create;

+ (NSArray *)findAll;

+ (NZActionComposite *)findLates;

- (void)destroy;

+ (void)destroyAll;

- (NZActionComposite *)clone;

@end
