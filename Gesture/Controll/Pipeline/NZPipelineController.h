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
 * check whether there is a backup of the pipeline
 */
//@property BOOL isBackup;

@property (nonatomic, retain) NSDictionary *testReport;
//@property (nonatomic, retain) NSDictionary *classifierParameters;

/**
 * adds a gesture and retrains the classifier for this gesture
 * @param isPositive true if it is a positive sample and false if it is a negative sample for this class label
 * @param sensorDataSample the sample containing the gesture recorded by the user to be added to the classification data set
 * @param classLabel the class label of the sample
 */
- (void)addPositive:(BOOL)isPositive sample:(NZSensorDataSet *)sensorDataSample withLabel:(NZClassLabel *)classLabel;

/**
 * adds a gesture and retrains the classifier for this gesture
 * @param isPositive true if it is a positive sample and false if it is a negative sample for this class label
 * @param samples an array of samples, each sample containing the gesture recorded by the user to be added to the classification data set
 * @param classLabel the class label of the sample
 */
- (void)addPositive:(BOOL)isPositive samples:(NSArray *)samples withLabel:(NZClassLabel *)classLabel;

/**
 * removes all samples from trainijng set
 * @param classLabel the class label of the sample
 */
- (void)removeAllSamplesWithLable:(NZClassLabel *)classLabel;

/**
 * train the classifier after adding new samples. Retrains the classifier if it was already trained
 * @note should be always called whenever new gesture has been added or modified
 */
- (BOOL)trainClassifier;

/**
 * classifies the sensor data set
 * @param set the data set to be classified
 * @return the predicted class label. If failed to classify or classifier not trained returns null;
 */
- (int)classifySensorDataSet:(NZSensorDataSet *)set;

/**
 * removes the class label form data set
 * @param classLabel the lable to be deleted
 */
- (void)removeClassLabel:(NZClassLabel *)classLabel;

/**
 * @return the number of classes in the pipeline
 */
- (int)numberOfClasses;

/**
 * @param index the index of the gestues class label
 * @return the number of training samples for the class with the given index
 */
- (int)numberOfSamplesForClassLabelIndex:(NSNumber *)index;


/**
 * saves the current pipeline and enables editing the model (especially important for the trained classification model)
 * @note should be used while testing the pipeline with different training sets. The pipeline can be rest after testig is done
 */
//- (void)backupCurrentPipeline;

/**
 * resets the pipeline to the last backuped pipeline
 * @note make sure to check if there is a pipeline to reset to
 */
//- (void)resetPipeline;

/**
 * test the pipeline
 * @param dataPartitioningConstant defines how to partition the available sample set into training and testing sets. The value is in percentage
 * @return the results of the testing
 */
- (NSDictionary *)testPipeline:(int)dataPartitioningConstant;

/**
 * saves the test results and the pipeline to file with the current timestamp
 * @note you can retrive the files via iTunes
 */
- (BOOL)saveTestResults;

@end
