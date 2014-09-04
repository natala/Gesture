//
//  NZWiFiPlugAction.h
//  Gesture
//
//  Created by Natalia Zarawska on 9/4/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "NZSingleAction.h"

static NSString *ENTITY_NAME_WIFIPLUG_ACTION = @"NZWiFiPlugAction";

@interface NZWiFiPlugAction : NZSingleAction

@property (nonatomic, retain) NSString * hostName;
@property (nonatomic, retain) NSString * portNumber;
@property (nonatomic, retain) NSString * plugId;
@property (nonatomic, retain) NSString * plugName;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * username;

@end
