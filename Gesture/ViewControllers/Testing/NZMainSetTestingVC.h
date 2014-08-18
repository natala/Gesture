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
- (IBAction)partitionRecordSegmentControlChangedValue:(id)sender;

@end
