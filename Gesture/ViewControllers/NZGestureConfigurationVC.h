//
//  NZGestureConfigurationVC.h
//  Gesture
//
//  Created by Natalia Zarawska on 7/17/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NZGesture.h"
#import "NZSensorDataRecordingManager.h"

@interface NZGestureConfigurationVC : UIViewController <NZSensorDataRecordingManagerObserver, UIPopoverControllerDelegate>

#pragma mark - properties
/**
 * The gesture to be configured
 */
@property (nonatomic, strong) NZGesture *gesture;


#pragma UI Elements
@property (weak, nonatomic) IBOutlet UIButton *learnGestureButton;
@property (weak, nonatomic) IBOutlet UILabel *numOfTrainingSamples;
@property (weak, nonatomic) IBOutlet UIButton *samplesButton;
@property (weak, nonatomic) IBOutlet UIButton *startStopRecordingGestureButton;

#pragma mark - functions
#pragma IBActions

/**
 * let the classifier learn this gestre
 */
- (IBAction)learnGestureTapped:(id)sender;

/**
 * start recording the data
 */
- (IBAction)startStopRecordingGestureButtonTouchDown:(id)sender;

/**
 * stop recording data
 */
- (IBAction)startStopRecordingGestureButtonTouchUpInside:(id)sender;


- (IBAction)setupHttpRequestButtonTapped:(id)sender;
- (IBAction)samplesButtonTapped:(id)sender;


@end
