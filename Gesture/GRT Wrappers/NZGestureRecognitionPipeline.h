//
//  NZGestureRecognitionPipeline.h
//  BLEDemo
//
//  Created by Natalia Zarawska on 13/04/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GRT.h"

@interface NZGestureRecognitionPipeline : NSObject

@property (strong) NSString *pipelineName;

/**
 * set the classifier of the pipeline
 */
- (void)setClassifier:(NSString *)classifier;

/**
 * train the pipeline with the training set
 */
- (BOOL)train:(GRT::LabelledClassificationData &)labelledData;

/**
 * test the performance of the classifier with the test set
 */
- (BOOL)test:(GRT::LabelledClassificationData &)testData;

/**
 * predict the class of the given sample
 */
- (int)predict:(GRT::VectorDouble &)data;

/**
 * Set up the pipeline (all the processing modules)
 */
- (void)setUpPipeline;

/**
 * returns the statistics of the trained pipeline
 * TODO: to be implemented
 */
- (NSString *)statistics;

/**
 * returns weather the classifier is trained
 */
- (BOOL)isTrained;

@end