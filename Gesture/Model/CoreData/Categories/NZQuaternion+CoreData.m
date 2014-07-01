//
//  NZSensorDataSet+CoreData.m
//  Gesture
//
//  Created by Natalia Zarawska on 7/1/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZQuaternion+CoreData.h"
#import "NSManagedObject+CoreData.h"

@implementation NZQuaternion (CoreData)

#pragma mark - Create
+(NZQuaternion *)create
{
    return (NZQuaternion *)[super createEntityWithName:ENTITY_NAME_QUATERNION];
}

#pragma mark - Find
+ (NSArray *)findAll
{
    return [super findAllEntitiesWithName:ENTITY_NAME_QUATERNION];
}

+ (NZQuaternion *)findLates
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
    [super destroyAllEntitiesWithName:ENTITY_NAME_QUATERNION];
}

@end
