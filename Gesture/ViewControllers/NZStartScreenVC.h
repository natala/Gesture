//
//  NZStartScreenVC.h
//  Gesture
//
//  Created by Natalia Zarawska on 9/10/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NZStartScreenVC;

@protocol NZStartScreenVCDelegate <NSObject, UIAlertViewDelegate, UIGestureRecognizerDelegate>

@required
- (void)startScreen:(NZStartScreenVC *)startScreen didSelectGestureSet:(NSString *)gestureSetName;

@end

@interface NZStartScreenVC : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) id<NZStartScreenVCDelegate> delegate;

#pragma mark - UI Elements
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton *renameButton;
@property (weak, nonatomic) IBOutlet UIButton *goButton;

#pragma mark - IB Actions
- (IBAction)goButtonTapped:(UIButton *)sender;
- (IBAction)renameButtonTapped:(UIButton *)sender;
- (IBAction)deleteButtonTapped:(UIButton *)sender;
- (IBAction)addButtonTapped:(UIButton *)sender;

@end
