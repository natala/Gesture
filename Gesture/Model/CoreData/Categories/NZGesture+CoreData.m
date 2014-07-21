//
//  NZGesture+CoreData.m
//  Gesture
//
//  Created by Natalia Zarawska on 7/16/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZGesture+CoreData.h"
#import "NZClassLabel+CoreData.h"
#import "NZSensorDataSet+CoreData.h"
#import "NSManagedObject+CoreData.h"

@implementation NZGesture (CoreData)

#pragma mark - Create
+(NZGesture *)create
{
    return (NZGesture *)[super createEntityWithName:ENTITY_NAME_GESTURE];
}

#pragma mark - Find

+ (NZGesture *)findGestureWithIndex:(NSNumber *)index
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"label.index == %@", index];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:ENTITY_NAME_GESTURE];
    request.predicate = predicate;
    NSError *error = nil;
    NSArray *foundEntities = [[NZCoreDataManager sharedManager].managedObjectContext executeFetchRequest:request error:&error];
    
    if (!foundEntities) {
        NSLog(@"couldn't find class label entity with index == %@", index);
        return nil;
    }
    if ([foundEntities count] > 1) {
        NSLog(@"WARNING - more than one entitie with index %@ found. Will return the first found one", index);
    }
    return (NZGesture *)foundEntities.firstObject;
}

+ (NZGesture *)findGestureWithLabel:(NZClassLabel *)label
{
    return [self findGestureWithIndex:label.index];
}

+ (NSArray *)findAll
{
    return [super findAllEntitiesWithName:ENTITY_NAME_GESTURE];
}

+ (NZGesture *)findLates
{
#warning incomplete implementation
    NSLog(@"NZSensorDataSet find lates to be implemented!!!");
    return nil;
}

#pragma mark - Destroy
- (void)destroy
{
    // destroy all class labels
    [self.label destroy];
    for (NZSensorDataSet *set in self.positiveSamples) {
        [set destroy];
    }
    for (NZSensorDataSet *set in self.negativeSamples) {
        [set destroy];
    }
    [super destroy];
}

+ (void)destroyAll
{
    [super destroyAllEntitiesWithName:ENTITY_NAME_GESTURE];
}

#pragma mark - Clone
- (NZGesture *)clone
{
    return (NZGesture *)[super clone];
}



@end
