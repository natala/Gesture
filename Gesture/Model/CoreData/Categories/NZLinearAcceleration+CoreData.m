//
//  NZSensorDataSet+CoreData.m
//  Gesture
//
//  Created by Natalia Zarawska on 7/1/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZLinearAcceleration+CoreData.h"
#import "NSManagedObject+CoreData.h"

@implementation NZLinearAcceleration (CoreData)

#pragma mark - Create
+(NZLinearAcceleration *)create
{
    return (NZLinearAcceleration *)[super createEntityWithName:ENTITY_NAME_LINEAR_ACCELERATION];
}

#pragma mark - Find
+ (NSArray *)findAll
{
    return [super findAllEntitiesWithName:ENTITY_NAME_LINEAR_ACCELERATION];
}

+ (NZLinearAcceleration *)findLates
{
#warning incomplete implementation
    NSLog(@"NZSensorDataSet find lates to be implemented!!!");
    return nil;
}

#pragma mark - Destroy
- (void)destroy
{
    [super destroy];
}

+ (void)destroyAll
{
    [super destroyAllEntitiesWithName:ENTITY_NAME_LINEAR_ACCELERATION];
}

@end
