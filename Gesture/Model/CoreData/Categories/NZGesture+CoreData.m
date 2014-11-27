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
#import "NZGestureSet.h"

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

+ (NSArray *)findAllSortetByLabel
{
    NSSortDescriptor *gestureSortDescripor = [[NSSortDescriptor alloc] initWithKey:@"label.name" ascending:YES];
    return [[NZGesture findAll]sortedArrayUsingDescriptors:@[gestureSortDescripor]];
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

#pragma mark - saving to file
- (void)saveToFile
{
    NSMutableString *fileName = [NSMutableString stringWithString:self.gestureSet.name];
    [fileName appendString:@" - "];
    [fileName appendString:self.label.name];
    [self saveToFileWithName:fileName];
    
}

- (void)saveToFileWithName:(NSString *)fileName
{
    NSMutableString *nameWithExtension = [NSMutableString stringWithString:fileName];
    [nameWithExtension appendString:@".xls"];
    NSString *path = [[self documentPath] stringByAppendingPathComponent:nameWithExtension];
    NSMutableString *string = [[NSMutableString alloc] initWithString:self.label.name];
    [string appendString:@"\t"];
    [string appendFormat:@"%@", self.label.index];
    
    NSArray *allSets = [self.positiveSamples allObjects];
    for (NZSensorDataSet *set in allSets) {
        [string appendString:@"\n"];
        [string appendString:[set sensorDataSetToString]];
    }
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSLog(@"Pipeline Controller is creating a new file for saving");
        if (![[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil]) {
            NSLog(@"Couldn't create file");
        }
    }
    NSFileHandle *handler = [NSFileHandle fileHandleForWritingAtPath:path];
    [handler writeData:[string dataUsingEncoding:NSUTF8StringEncoding]];
}


#pragma mark - Helpers

- (NSString *)documentPath
{
    NSArray *searchPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [searchPath objectAtIndex:0];
}

@end
