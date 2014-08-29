//
//  NZAction.h
//  Gesture
//
//  Created by Natalia Zarawska on 8/28/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

static NSString *ENTITY_NAME_ACTION = @"NZAction";

@class NZActionComposite;

@interface NZAction : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NZActionComposite *parentAction;

@end
