//
//  NZGestureRecognitionPipeline.m
//  BLEDemo
//
//  Created by Natalia Zarawska on 13/04/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZGestureRecognitionPipeline.h"
#import <fstream>
#import <string>
#import <sstream>
#import <iostream>

@interface NZGestureRecognitionPipeline ()

@property NSString *fileHeader;

@end

@implementation NZGestureRecognitionPipeline

GRT::GestureRecognitionPipeline pipeline;

- (id)init
{
    self = [super init];
    if ( self ) {
        pipeline = GRT::GestureRecognitionPipeline();
        _pipelineName = @"test pipeline";
        self.fileHeader = @"GRT_PIPELINE_FILE_V1.0";
    }
    return self;
}

- (void)setClassifier:(NSString *)classifier
{
    if ([classifier isEqualToString:@"SVM"]) {
        pipeline.setClassifier(GRT::SVM());
    } else {
        pipeline.setClassifier(GRT::KNN());
    }
    
    pipeline.getClassifier()->enableNullRejection(true);
}

- (void)setUpPipeline
{
    // add filter
    GRT::HighPassFilter filter = GRT::HighPassFilter(0.1, 1, 3);
    pipeline.addPreProcessingModule(filter);
    
    // add Feature extractors
    GRT::ZeroCrossingCounter zeroCrossing = GRT::ZeroCrossingCounter(30, 0.1, 3);
    GRT::FFT fft(256,1);
    pipeline.addFeatureExtractionModule(fft);
    pipeline.addFeatureExtractionModule(zeroCrossing);
}

- (BOOL)train:(GRT::LabelledClassificationData &)labelledData
{
    if( !pipeline.train( labelledData ) ){
        NSLog(@"ERROR: Failed to train the pipeline!");
        return false;
    }
    return true;
}

- (BOOL)test:(GRT::LabelledClassificationData &)testData
{
    // 4. Test the pipeline using the test data
    if( !pipeline.test( testData ) ){
        NSLog( @"ERROR: Failed to test the pipeline!");
        return false;
    }
    
    // 5. Print some stats about the testing
    NSLog(@"Test Accuracy: %f", pipeline.getTestAccuracy());
    
    /*
     cout << "Precision: ";
     for(UINT k=0; k<pipeline.getNumClassesInModel(); k++){
     UINT classLabel = pipeline.getClassLabels()[k];
     cout << "\t" << pipeline.getTestPrecision(classLabel);
     }cout << endl;
     
     cout << "Recall: ";
     for(UINT k=0; k<pipeline.getNumClassesInModel(); k++){
     UINT classLabel = pipeline.getClassLabels()[k];
     cout << "\t" << pipeline.getTestRecall(classLabel);
     }cout << endl;
     
     cout << "FMeasure: ";
     for(UINT k=0; k<pipeline.getNumClassesInModel(); k++){
     UINT classLabel = pipeline.getClassLabels()[k];
     cout << "\t" << pipeline.getTestFMeasure(classLabel);
     }cout << endl;
     
     Matrix< double > confusionMatrix = pipeline.getTestConfusionMatrix();
     cout << "ConfusionMatrix: \n";
     for(UINT i=0; i<confusionMatrix.getNumRows(); i++){
     for(UINT j=0; j<confusionMatrix.getNumCols(); j++){
     cout << confusionMatrix[i][j] << "\t";
     }cout << endl;
     }
     */
    return true;
}

- (NSString *)statistics
{
    NSString *stats = @"some stats";
    return stats;
}

- (int)predict:(GRT::VectorDouble &)data
{
    if (!pipeline.getTrained()) {
        return -1;
    }
    pipeline.predict(data);
    return pipeline.getPredictedClassLabel();
}

- (BOOL)isTrained
{
    return pipeline.getTrained();
}


#pragma mark -
#pragma NSCoding
#pragma mark -

#define kFileHeader @"FileHeader"
#define kPipelineMode @"PipelineMode"
#define kNumPreprocessingModules @"NumPreprocessingModules"
#define kNumFeatureExtractionModules @"NumFeatureExtractionModules"
#define kNumPostprocessingModules @"NumPostprocessingModules"
#define kTrained @"Trained"
#define kPreProcessingType @"PreProcessingType"
#define kFeatureExtractionType @"FeatureExtractionType"
// set to @"" if not set
#define kClassifierType @"ClassifierType"
// set to @"" if not set
#define kRegressifierType @"RegressifierType"
#define kPostProcessingType @"PostProcessingType"
#define kPreProcessingModule @"PreProcessingModule"

@end
