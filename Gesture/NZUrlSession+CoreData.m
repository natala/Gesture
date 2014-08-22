//
//  NZUrlSession+CoreData.m
//  Gesture
//
//  Created by Natalia Zarawska on 7/1/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZUrlSession+CoreData.h"
#import "NSManagedObject+CoreData.h"

@implementation NZUrlSession (CoreData)

#pragma mark - Create
+(NZUrlSession *)create
{
    return (NZUrlSession *)[super createEntityWithName:ENTITY_NAME_URL_SESSION];
}

#pragma mark - Find
+ (NSArray *)findAll
{
    return [super findAllEntitiesWithName:ENTITY_NAME_URL_SESSION];
}

+ (NZUrlSession *)findLates
{
#warning incomplete implementation
    NSLog(@"NZUrlSession find lates to be implemented!!!");
    return nil;
}

#pragma mark - Destroy
- (void)destroy
{
    [super destroy];
}

+ (void)destroyAll
{
    [super destroyAllEntitiesWithName:ENTITY_NAME_URL_SESSION];
}

@end
