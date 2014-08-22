//
//  NZHttpRequest+CoreData.m
//  Gesture
//
//  Created by Natalia Zarawska on 7/1/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZHttpRequest+CoreData.h"
#import "NSManagedObject+CoreData.h"

@implementation NZHttpRequest (CoreData)

#pragma mark - Create
+(NZHttpRequest *)create
{
    return (NZHttpRequest *)[super createEntityWithName:ENTITY_NAME_HTTP_REQUEST];
}

#pragma mark - Find
+ (NSArray *)findAll
{
    return [super findAllEntitiesWithName:ENTITY_NAME_HTTP_REQUEST];
}

+ (NZHttpRequest *)findLates
{
#warning incomplete implementation
    NSLog(@"NZHttpRequest find lates to be implemented!!!");
    return nil;
}

#pragma mark - Destroy
- (void)destroy
{
    [super destroy];
}

+ (void)destroyAll
{
    [super destroyAllEntitiesWithName:ENTITY_NAME_HTTP_REQUEST];
}

@end
