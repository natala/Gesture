//
//  NZUrlSession.h
//  Gesture
//
//  Created by Natalia Zarawska on 8/22/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "NZSingleAction.h"

static NSString *ENTITY_NAME_URL_SESSION = @"NZUrlSession";


@interface NZUrlSession : NZSingleAction

@property (nonatomic, retain) NSString * url;

@end
