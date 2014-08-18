//
//  NZMainSetTestingVC.h
//  Gesture
//
//  Created by Natalia Zarawska on 8/11/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NZGestureSet.h"

@interface NZMainSetTestingVC : UIViewController <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>
@property (nonatomic, strong) NZGestureSet *gestureSet;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *partitionConstantTextField;
@property (weak, nonatomic) IBOutlet UITextView *testReportTextView;
@property (weak, nonatomic) IBOutlet UIButton *testButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

#pragma mark - IBActins
- (IBAction)partitionRecordSegmentControlChangedValue:(id)sender;
- (IBAction)didEdidPartitionConstatntTextField:(id)sender;
- (IBAction)testTapped:(id)sender;
- (IBAction)saveButtonTapped:(id)sender;

@end
