//
//  NZActionComposite+CoreData.m
//  Gesture
//
//  Created by Natalia Zarawska on 7/1/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZActionComposite+CoreData.h"
#import "NSManagedObject+CoreData.h"

@implementation NZActionComposite (CoreData)

#pragma mark - Create
+(NZActionComposite *)create
{
    return (NZActionComposite *)[super createEntityWithName:ENTITY_NAME_ACTION_COMPOSITE];
}

#pragma mark - Find
+ (NSArray *)findAll
{
    return [super findAllEntitiesWithName:ENTITY_NAME_ACTION_COMPOSITE];
}

+ (NZActionComposite *)findLates
{
#warning incomplete implementation
    NSLog(@"NZActionComposite find lates to be implemented!!!");
    return nil;
}

#pragma mark - Destroy
- (void)destroy
{
    [super destroy];
}

+ (void)destroyAll
{
    [super destroyAllEntitiesWithName:ENTITY_NAME_ACTION_COMPOSITE];
}

#pragma mark - Clone
- (NZActionComposite *)clone
{
    return (NZActionComposite *)[super clone];
}

@end
