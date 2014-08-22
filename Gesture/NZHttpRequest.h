//
//  NZHttpRequest.h
//  Gesture
//
//  Created by Natalia Zarawska on 8/22/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

static NSString *ENTITY_NAME_HTTP_REQUEST = @"NZHttpRequest";

@interface NZHttpRequest : NSManagedObject

@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * message;
@property (nonatomic, retain) NSString * httpMethod;

@end
