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

@interface NZGestureConfigurationVC : UIViewController <NZSensorDataRecordingManagerObserver>

#pragma mark - properties
/**
 * The gesture to be configured
 */
@property (nonatomic, strong) NZGesture *gesture;

@property (weak, nonatomic) IBOutlet UIButton *startGestureButton;
@property (weak, nonatomic) IBOutlet UIButton *stopGestureButton;



#pragma mark - functions
#pragma IBActions
/**
 * start recording sensor data
 */
- (IBAction)startGestureTapped:(id)sender;


/**
 * stop recording data
 */
- (IBAction)stopGestureTapped:(id)sender;

@end
