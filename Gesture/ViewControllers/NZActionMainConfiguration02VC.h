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
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *singleGroupSegment;

#pragma mark - IB Actions
- (IBAction)singleGroupSegmentValueChanged:(UISegmentedControl *)sender;
- (IBAction)editButtonTapped:(UIButton *)sender;
- (IBAction)addButtonTapped:(UIButton *)sender;

@end
