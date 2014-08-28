//
//  NZAction.h
//  Gesture
//
//  Created by Natalia Zarawska on 8/25/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

static NSString *ENTITY_NAME_ACTION = @"NZAction";

@interface NZAction : NSManagedObject

@property (nonatomic, retain) NSString * name;

@end
