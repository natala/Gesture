//
//  NZSensorDataSet+CoreData.m
//  Gesture
//
//  Created by Natalia Zarawska on 7/1/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZSensorDataSet+CoreData.h"
#import "NZSensorData+CoreData.h"
#import "NSManagedObject+CoreData.h"

@implementation NZSensorDataSet (CoreData)

#pragma mark - Create
+(NZSensorDataSet *)create
{
    return (NZSensorDataSet *)[super createEntityWithName:ENTITY_NAME_SENSOR_DATA_SET];
}

#pragma mark - Find
+ (NSArray *)findAll
{
    return [super findAllEntitiesWithName:ENTITY_NAME_SENSOR_DATA_SET];
}

+ (NZSensorDataSet *)findLates
{
#warning incomplete implementation
    NSLog(@"NZSensorDataSet find lates to be implemented!!!");
    return nil;
}

#pragma mark - Destroy
- (void)destroy
{
    for (NZSensorData *data in self.sensorData) {
        [data destroy];
    }
    [super destroy];
}

+ (void)destroyAll
{
    [super destroyAllEntitiesWithName:ENTITY_NAME_SENSOR_DATA_SET];
}

#pragma mark - Clone
- (NZSensorDataSet *)clone
{
    return (NZSensorDataSet *)[super clone];
}

- (NSString *)sensorDataSetToString
{
    NSArray *dataArray = [self.sensorData allObjects];
    NSMutableString *string = [[NSMutableString alloc] initWithString:@"linear acceleration/tquaternions\tyaw pitch roll\tgravity"];
    for (NZSensorData *data in dataArray) {
        [string appendString:@"\n"];
        [string appendString:[data sensorValuesAsString]];
    }
    return string;
}

@end
