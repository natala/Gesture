//
//  MainGestureConfigurationVC.h
//  Gesture
//
//  Created by Natalia Zarawska on 9/25/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NZSensorDataRecordingManager.h"

#import "NZEditGestureSamplesTVC.h"
#import "NZGestureActionMappingVC.h"
#import "NZArduinoCommunicationManager.h"

@interface NZMainGestureConfigurationVC : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UIPopoverControllerDelegate, NZSensorDataRecordingManagerObserver, NZEditingGestureSamplesTVCDelegare, NZGestureActionMappingVCDelegate, NZArduinoCommunicationManagerObserver>

#pragma mark - UIElements
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *isNotConnectedLabel;

#pragma mark - IBActions
- (IBAction)samplesButtonTapped:(UIButton *)sender;
- (IBAction)cameraButtonTapped:(UIButton *)sender;
- (IBAction)checkButtonTapped:(UIButton *)sender;
- (IBAction)actionsButtonTapped:(UIButton *)sender;


- (IBAction)plusButtonTapped:(UIButton *)sender;
- (IBAction)minusButtonTapped:(UIButton *)sender;

- (IBAction)connectButtonTapped:(UIButton *)sender;

- (void)updateSamplesButton;

@end
