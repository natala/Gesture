//
//  NZPipelineController.h
//  Gesture
//
//  Created by Natalia Zarawska on 7/17/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NZGesture.h"

@protocol NZPipelineControllerDelegate <NSObject>

@end


@interface NZPipelineController : NSObject

/**
 * Creates and returns the singleton instance of the pipeline controller.
 * @author  Natalia Zarawska
 * @return  The singleton instance of the pipeline controller.
 */
+ (NZPipelineController *)sharedManager;

@property (nonatomic, retain) id<NZPipelineControllerDelegate> delegate;


/**
 * adds a gesture and retrains the classifier for this gesture
 * @param isPositive true if it is a positive sample and false if it is a negative sample for this class label
 * @param sensorDataSample the sample containing the gesture recorded by the user to be added to the classification data set
 * @param classLabel the class label of the sample
 */
- (void)addPositive:(BOOL)isPositive sample:(NZSensorDataSet *)sensorDataSample withLabel:(NZClassLabel *)classLabel;

/**
 * train the classifier after adding new samples
 */
- (BOOL)trainClassifier;


@end
