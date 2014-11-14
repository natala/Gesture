//
//  NZLocation.h
//  Gesture
//
//  Created by Natalia Zarawska on 11/13/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


static NSString *ENTITY_NAME_LOCATION = @"NZLocation";

@class NZAction;

@interface NZLocation : NSManagedObject

@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* uuid;
@property (nonatomic, retain) NSSet *action;
@end

@interface NZLocation (CoreDataGeneratedAccessors)

- (void)addActionObject:(NZAction *)value;
- (void)removeActionObject:(NZAction *)value;
- (void)addAction:(NSSet *)values;
- (void)removeAction:(NSSet *)values;

@end
