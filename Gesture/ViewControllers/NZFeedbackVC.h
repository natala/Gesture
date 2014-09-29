//
//  NZFeedbackVC.h
//  Gesture
//
//  Created by Natalia Zarawska on 9/29/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NZGesture+CoreData.h"

@protocol NZFeedbackVCDelegate <NSObject>

/**
 * @param shouldCorrect true if the user selected the correct action and false otherwise
 */
- (void)shouldDismissVc:(UIViewController *)vc withAndCorrectRecognition:(BOOL)shouldCorrect;

@end

@interface NZFeedbackVC : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate>

@property (retain, nonatomic) id<NZFeedbackVCDelegate> delegate;

@property (retain, nonatomic) NZGesture *recognizedGesture;
@property (retain, nonatomic) NZGesture *correctGesture;

#pragma mark - IB Actions
- (IBAction)doneButtonTapped:(UIButton *)sender;
- (IBAction)cancelButtonTapped:(UIButton *)sender;

@end
