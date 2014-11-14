//
//  NZActionGroupConfigurationPopoverTVTableViewController.h
//  Gesture
//
//  Created by Natalia Zarawska on 11/13/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NZActionComposite+CoreData.h"

@interface NZActionGroupConfigurationPopoverTVC : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NZActionComposite *groupAction;

#pragma mark - UI Elements
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *groupNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *editButton;



#pragma mark - IB Actions
- (IBAction)editButtonTapped:(UIButton *)sender;
- (IBAction)closeButtonTapped:(UIButton *)sender;



@end
