//
//  NZHttpRequest.h
//  Gesture
//
//  Created by Natalia Zarawska on 9/8/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "NZSingleAction.h"

static NSString *ENTITY_NAME_HTTP_REQUEST = @"NZHttpRequest";

@interface NZHttpRequest : NZSingleAction

@property (nonatomic, retain) NSString * httpMethod;
@property (nonatomic, retain) NSString * message;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * httpHeaderAccept;
@property (nonatomic, retain) NSString * httpHeaderContentType;

@end
