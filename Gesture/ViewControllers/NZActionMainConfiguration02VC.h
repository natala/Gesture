//
//  NZActionMainConfiguration02VC.h
//  Gesture
//
//  Created by Natalia Zarawska on 11/13/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NZActionMainConfiguration02VC : UIViewController <UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

#pragma mark - UI Elements
@property (weak, nonatomic) IBOutlet UIPickerView *locationsPickerView;
@property (weak, nonatomic) IBOutlet UITableView *actionsTableView;

#pragma mark - IB Actions
- (IBAction)singleGroupSegmentValueChanged:(UISegmentedControl *)sender;

@end
