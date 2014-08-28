//
//  NZSingleAction+CoreData.m
//  Gesture
//
//  Created by Natalia Zarawska on 7/1/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZSingleAction+CoreData.h"
#import "NSManagedObject+CoreData.h"

@implementation NZSingleAction (CoreData)

#pragma mark - Create
+(NZSingleAction *)create
{
    return (NZSingleAction *)[super createEntityWithName:ENTITY_NAME_SINGLE_ACTION];
}

#pragma mark - Find
+ (NSArray *)findAll
{
    return [super findAllEntitiesWithName:ENTITY_NAME_SINGLE_ACTION];
}

+ (NSArray *)findAllSortedByName
{
    NSSortDescriptor *actionSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    return [[NZSingleAction findAll] sortedArrayUsingDescriptors:@[actionSortDescriptor]];
}

+ (NZSingleAction *)findLates
{
#warning incomplete implementation
    NSLog(@"NZSingleAction find lates to be implemented!!!");
    return nil;
}

#pragma mark - Destroy
- (void)destroy
{
    [super destroy];
}

+ (void)destroyAll
{
    [super destroyAllEntitiesWithName:ENTITY_NAME_SINGLE_ACTION];
}

@end
