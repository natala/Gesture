//
//  NZSensorDataSet+CoreData.m
//  Gesture
//
//  Created by Natalia Zarawska on 7/1/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZClassLabel+CoreData.h"
#import "NSManagedObject+CoreData.h"

@implementation NZClassLabel (CoreData)

#pragma mark - Create
+(NZClassLabel *)create
{
    return (NZClassLabel *)[super createEntityWithName:ENTITY_NAME_CLASS_LABEL];
}

#pragma mark - Find
+ (NSArray *)findAll
{
    return [super findAllEntitiesWithName:ENTITY_NAME_CLASS_LABEL];
}

+ (NZClassLabel *)findLates
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
    [super destroyAllEntitiesWithName:ENTITY_NAME_CLASS_LABEL];
}

@end
