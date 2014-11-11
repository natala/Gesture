//
//  NZClassificationController.h
//  Gesture
//
//  Created by Natalia Zarawska on 11/11/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GRT.h"

@interface NZClassificationController : NSObject

/**
 * preprocessinf modules
 */
@property NSArray* preprocessingModules;

#pragma mark - methods

#pragma mark - init
- (instancetype)initWithClassifier:(GRT::DTW) dtw;

- (instancetype)initFromFile:(NSString *)fileName;


#pragma mark - training related methods

- (bool)trainGestureWithLabel:(GRT::UINT) label;

- (bool)train;

- (void)addTrainindSample:(GRT::MatrixDouble) sample withLabel:(GRT::UINT) label;

- (void)removeAllSamplesWithLable:(GRT::UINT)classLabel;

- (bool)saveClassifierToFileWithName:(NSString *)path;

- (int)predict:(GRT::MatrixDouble) data;

#pragma mark - getters & setters
- (void)setTrainingData:(GRT::TimeSeriesClassificationData) trainingData;

@end
