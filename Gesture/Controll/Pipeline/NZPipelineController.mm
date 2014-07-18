//
//  NZPipelineController.m
//  Gesture
//
//  Created by Natalia Zarawska on 7/17/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZPipelineController.h"
#import "NZSensorData.h"
#import "NZSensorDataSet.h"
#import "NZLinearAcceleration.h"
#import "NZQuaternion.h"
#import "NzClassLabel.h"
#import "NZGesture+CoreData.h"
#import <fstream>
#import <string>
#import <sstream>
#import <iostream>
#import "GRT.h"


NSString *const kGrtPipelineFileName = @"pipelineFile.txt";

@interface NZPipelineController ()

//@property GRT::GestureRecognitionPipeline *grtPipeline;

@end

@implementation NZPipelineController

GRT::GestureRecognitionPipeline grtPipeline;
GRT::TimeSeriesClassificationData trainingData;

#pragma mark - Singleton

+ (NZPipelineController *)sharedManager
{
    static NZPipelineController *sharedManager = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedManager = [NZPipelineController new];
    });
    
    return sharedManager;
}


- (id)init
{
    self = [super init];
    if (self) {
        grtPipeline = GRT::GestureRecognitionPipeline();
        NSString *path = [[NZPipelineController documentPath] stringByAppendingPathComponent:kGrtPipelineFileName];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
            NSLog(@"Pipeline Controller is creating a new file for saving");
            if (![[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil]) {
                NSLog(@"Couldn't create file");
            }
        }
        
        if ( !grtPipeline.loadPipelineFromFile([path UTF8String]) ) {
            NSLog(@"Couldn't load pipeline from file. Set up a new one");
            // create a new pipeline with th DTW classifier and save
            grtPipeline.setClassifier( GRT::DTW() );
            if( !grtPipeline.savePipelineToFile([path UTF8String]) ) {
                NSLog(@"Could't initially save pipeline to file");
                abort();
            }
        }
        [self initTheClassificationData];
    }
    return self;
}

#pragma mark - classification related methods

- (void)addPositive:(BOOL)isPositive sample:(NZSensorDataSet *)sensorDataSample withLabel:(NZClassLabel *)classLabel
{
    
    GRT::MatrixDouble grtDataSample = [NZPipelineController convertSensorDataSet:sensorDataSample];
    //NSLog(@"%f", grtDataSample[0][0]);
    //!!! 0 is reserved for the null gesture, not allowed to use it when adding a sample
    GRT::UINT gestureLabel = (unsigned int)[classLabel.index unsignedIntegerValue];
    trainingData.addSample(gestureLabel, grtDataSample);
    
}

- (BOOL)trainClassifier
{
    BOOL res = grtPipeline.train(trainingData);
    if (!res) {
        NSLog(@"unable to train classifier!!!");
    }
    return res;
}

#pragma mark - Init helper functions
- (void)initTheClassificationData
{
    // set up the classification data with dimension
    // linera acceleration (3) + quiaterions (4) = 7
    trainingData = GRT::TimeSeriesClassificationData(7);
    trainingData.setDatasetName("TrainingSetTest");
    [self loadAllGesture];
}

/**
 * loads all gestures form the database (CoreData)
 */
- (void)loadAllGesture
{
    //NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:ENTITY_NAME_GESTURE];
    //NSManagedObjectContext *context = [[NZCoreDataManager sharedManager] managedObjectContext];
    NSArray *allGestures = [NZGesture findAll];
    for (NZGesture *gesture in allGestures) {
        for (NZSensorDataSet *set in gesture.positiveSamples) {
            [self addPositive:YES sample:set withLabel:gesture.label];
        }
        for (NZSensorDataSet *set in gesture.negativeSamples) {
            NSLog(@"!!!!! adding negative samples not yet implemented !!!!!");
        }
    }
}

#pragma mark - Helpers

+ (NSString *)documentPath
{
    NSArray *searchPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [searchPath objectAtIndex:0];
}

#pragma mark - GRT helper function

+ (GRT::MatrixDouble)convertSensorDataSet:(NZSensorDataSet *)set
{
    GRT::MatrixDouble trainingSample;
    for (NZSensorData *data in set.sensorData) {
        trainingSample.push_back([NZPipelineController convertSensorData:data]);
    }
    // NSLog(@"%f", trainingSample[0][0]);
    return trainingSample;

}

+ (GRT::VectorDouble)convertSensorData:(NZSensorData *)sensorData
{
    GRT::VectorDouble sample;
    if (!sensorData.linearAcceleration) {
        NSLog(@"No acceleration set!!!");
        abort();
    }
    if (!sensorData.quaternion) {
        NSLog(@"No quaternions set!!!");
        abort();
    }
    NZLinearAcceleration *acc = sensorData.linearAcceleration ;
    NZQuaternion *quaternions = sensorData.quaternion;
    
    double d = [(NSNumber *)[acc valueForKeyPath:@"x"] doubleValue];
    sample.push_back(d);
    d = [(NSNumber *)[acc valueForKeyPath:@"y"] doubleValue];
    sample.push_back(d);
    d = [(NSNumber *)[acc valueForKeyPath:@"z"] doubleValue];
    sample.push_back(d);
    
    d = [(NSNumber *)[quaternions valueForKeyPath:@"w"] doubleValue];
    sample.push_back(d);
    d = [(NSNumber *)[quaternions valueForKeyPath:@"x"] doubleValue];
    sample.push_back(d);
    d = [(NSNumber *)[quaternions valueForKeyPath:@"y"] doubleValue];
    sample.push_back(d);
    d = [(NSNumber *)[quaternions valueForKeyPath:@"z"] doubleValue];
    sample.push_back(d);
   // NSLog(@"%lu", sample.size());
   // NSLog(@"%f", sample[0]);
    return sample;
}


@end
