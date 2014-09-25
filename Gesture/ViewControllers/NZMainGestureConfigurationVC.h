//
//  MainGestureConfigurationVC.h
//  Gesture
//
//  Created by Natalia Zarawska on 9/25/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NZMainGestureConfigurationVC : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UIPopoverControllerDelegate>

#pragma mark - IBActions
- (IBAction)samplesButtonTapped:(UIButton *)sender;
- (IBAction)cameraButtonTapped:(UIButton *)sender;
- (IBAction)checkButtonTapped:(UIButton *)sender;


- (IBAction)plusButtonTapped:(UIButton *)sender;
- (IBAction)minusButtonTapped:(UIButton *)sender;


@end