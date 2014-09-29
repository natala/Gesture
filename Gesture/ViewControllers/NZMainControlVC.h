//
//  NZMainControlVC.h
//  Gesture
//
//  Created by Natalia Zarawska on 7/18/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NZSensorDataRecordingManager.h"
#import "NZActionController.h"
#import "NZFeedbackVC.h"

@interface NZMainControlVC : UIViewController <NZSensorDataRecordingManagerObserver, NZActionControllerObserver, UIAlertViewDelegate, NZFeedbackVCDelegate, UIPopoverControllerDelegate>

#pragma mark - UI Elements
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *singleGroupSegmentControl;

@property (weak, nonatomic) IBOutlet UIButton *stopStartGestureButton;
@property (weak, nonatomic) IBOutlet UILabel *recognizedGestureNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *executedActionLabel;
@property (weak, nonatomic) IBOutlet UILabel *debugMessageLabel;

@property (weak, nonatomic) IBOutlet UILabel *notConnectedLabel;


#pragma mark - IBActions
- (IBAction)startButtonTapped:(id)sender;
- (IBAction)stopButtonTapped:(id)sender;
- (IBAction)singleGroupModeChanged:(id)sender;
//- (IBAction)startStopGestureTapped:(id)sender;
- (IBAction)startStopGestureTouchDown:(id)sender;
- (IBAction)startStopGestureTouchUpInside:(id)sender;


@end
