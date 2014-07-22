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
#import <vector>


NSString *const kGrtPipelineFileName = @"pipelineFile.txt";

@interface NZPipelineController ()

//@property GRT::GestureRecognitionPipeline *grtPipeline;

@end

@implementation NZPipelineController

GRT::GestureRecognitionPipeline grtPipeline;
GRT::TimeSeriesClassificationData trainingData;
GRT::TimeSeriesClassificationData dataToBeClassified;

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
        //grtPipeline = GRT::GestureRecognitionPipeline();
        NSString *path = [[NZPipelineController documentPath] stringByAppendingPathComponent:kGrtPipelineFileName];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
            NSLog(@"Pipeline Controller is creating a new file for saving");
            if (![[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil]) {
                NSLog(@"Couldn't create file");
            }
        }
        BOOL init = grtPipeline.getIsInitialized();
        if ( !grtPipeline.loadPipelineFromFile([path UTF8String]) ) {
            grtPipeline = GRT::GestureRecognitionPipeline();
            init = grtPipeline.getIsInitialized();
            NSLog(@"Couldn't load pipeline from file. Set up a new one");
            // create a new pipeline with th DTW classifier and save
            GRT::DTW dtw = GRT::DTW();
            dtw.enableNullRejection(true);
            dtw.setRejectionMode(GRT::DTW::RejectionModes::TEMPLATE_THRESHOLDS);
            dtw.enableScaling(false);
            dtw.enableZNormalization(true);
            grtPipeline.setClassifier( GRT::DTW() );
            if( !grtPipeline.savePipelineToFile([path UTF8String]) ) {
                NSLog(@"Could't initially save pipeline to file");
                abort();
            }
        }
        init = grtPipeline.getIsInitialized();
        [self initTheClassificationData];
    }
    return self;
}

#pragma mark - classification related methods

- (void)addPositive:(BOOL)isPositive sample:(NZSensorDataSet *)sensorDataSample withLabel:(NZClassLabel *)classLabel
{
    GRT::DTW dtw = (GRT::DTW)grtPipeline.getClassifier();
    std::vector<GRT::DTWTemplate> templates = dtw.getModels();
    for (int i = 0; i < templates.size(); i++) {
        GRT::MatrixDouble matrix = templates[i].timeSeries;
    }
    GRT::MatrixDouble grtDataSample = [NZPipelineController convertSensorDataSet:sensorDataSample];
    //NSLog(@"%f", grtDataSample[0][0]);
    //!!! 0 is reserved for the null gesture, not allowed to use it when adding a sample
    GRT::UINT gestureLabel = (unsigned int)[classLabel.index unsignedIntegerValue];
    trainingData.addSample(gestureLabel, grtDataSample);
    
}

- (void)removeAllSamplesWithLable:(NZClassLabel *)classLabel
{
    trainingData.eraseAllSamplesWithClassLabel([classLabel.index unsignedIntegerValue]);
}

- (void)addPositive:(BOOL)isPositive samples:(NSArray *)samples withLabel:(NZClassLabel *)classLabel
{
    for (NZSensorDataSet *sample in samples) {
        [self addPositive:isPositive sample:sample withLabel:classLabel];
    }
}

- (int)numberOfClasses
{
   // GRT::DTW *dtw = (GRT::DTW *)grtPipeline.getClassifier();
   // int numTemplates = dtw->getNumTemplates();
   // int numClasses = grtPipeline.getNumClassesInModel();
   // int numModels = dtw->getModels().size();
    return grtPipeline.getNumClassesInModel();
}

- (BOOL)trainClassifier
{
    BOOL res = grtPipeline.train(trainingData);
    if (!res) {
        NSLog(@"unable to train classifier!!!");
    }
    [self savePipelneToFile];
    return res;
}


- (int)classifySensorDataSet:(NZSensorDataSet *)set
{
    NSLog(@"classify!!!!");
    GRT::MatrixDouble dataMatrix = [NZPipelineController convertSensorDataSet:set];
    if (! grtPipeline.predict(dataMatrix)) {
        return -1;
    }
    return grtPipeline.getPredictedClassLabel();
}

- (BOOL)savePipelneToFile
{
    NSString *path = [[NZPipelineController documentPath] stringByAppendingPathComponent:kGrtPipelineFileName];
    return grtPipeline.savePipelineToFile([path UTF8String]);
}

- (void)removeClassLabel:(NZClassLabel *)classLabel
{
    trainingData.eraseAllSamplesWithClassLabel([classLabel.index unsignedIntegerValue]);
}

#pragma mark - Init helper functions
- (void)initTheClassificationData
{
    // set up the classification data with dimension
    // linera acceleration (3) + quiaterions (4) = 7
    trainingData = GRT::TimeSeriesClassificationData(7);
    trainingData.setDatasetName("TrainingSetTest");
    [self loadAllGesture];
    dataToBeClassified = GRT::TimeSeriesClassificationData(7);
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

- (int)numberOfSamplesForClassLabelIndex:(NSNumber *)index
{
    
    return trainingData.getClassData([index intValue]).getNumSamples();
}

@end
