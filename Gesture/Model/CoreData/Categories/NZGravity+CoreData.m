//
//  NZSensorDataSet+CoreData.m
//  Gesture
//
//  Created by Natalia Zarawska on 7/1/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZGravity+CoreData.h"
#import "NSManagedObject+CoreData.h"

@implementation NZGravity (CoreData)

#pragma mark - Create
+(NZGravity *)create
{
    return (NZGravity *)[super createEntityWithName:ENTITY_NAME_GRAVITY];
}

#pragma mark - Find
+ (NSArray *)findAll
{
    return [super findAllEntitiesWithName:ENTITY_NAME_GRAVITY];
}

+ (NZGravity *)findLates
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
    [super destroyAllEntitiesWithName:ENTITY_NAME_GRAVITY];
}

- (NSString *)valuesToString
{
    NSString *string = [NSString stringWithFormat:@"%f\t%f\t%f", [self.x floatValue], [self.y floatValue], [self.z floatValue]];
    return string;
}

- (void)normalize
{
    // noone cares about gravity :P
}

@end
