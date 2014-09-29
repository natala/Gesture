//
//  NZActionsMainConfiguration.h
//  Gesture
//
//  Created by Natalia Zarawska on 9/26/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NZActionsMainConfiguration : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource, UITableViewDelegate>

#pragma mark - IB Actions
- (IBAction)gesturesButtonTapped:(UIButton *)sender;
- (IBAction)plusButtonTapped:(UIButton *)sender;
- (IBAction)minusButtonTapped:(UIButton *)sender;

@end