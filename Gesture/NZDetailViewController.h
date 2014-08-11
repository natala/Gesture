//
//  NZDetailViewController.h
//  Gesture
//
//  Created by Natalia Zarawska on 6/26/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NZSensorDataRecordingManager.h"
#import "KHSensorDataLineChartView.h"
#import "KHLinearAccelerationLineChartView.h"
#import "KHYawPitchRollLineChartView.h"
#import "Views/RecordingSensorDataTableView/NZSensorDataTableView.h"
#import "NZGraphView.h"

@interface NZDetailViewController : UIViewController <UISplitViewControllerDelegate, NZSensorDataRecordingManagerObserver, NSFetchedResultsControllerDelegate /*, UITableViewDataSource*/>

#pragma mark - UI Components
@property (weak, nonatomic) IBOutlet UIButton *startRecordingButton;
@property (weak, nonatomic) IBOutlet UIButton *stopRecordingButton;
@property (weak, nonatomic) IBOutlet UILabel *recordingStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *accelerationLabel;
@property (weak, nonatomic) IBOutlet UILabel *orientationLabel;

#pragma mark - Core Data related properties
// @property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
// @property (weak, nonatomic) IBOutlet UITableView *sensorDataTableView;

#pragma mark - detailed views


#pragma mark - views
@property (weak, nonatomic) IBOutlet KHLinearAccelerationLineChartView *linearAccelerationLineChartView;
@property (weak, nonatomic) IBOutlet KHYawPitchRollLineChartView *yawPitchRollLineChartView;

//@property (weak, nonatomic) IBOutlet NZGraphView *linearAccelerationLineChartView;
//@property (weak, nonatomic) IBOutlet NZGraphView *yawPitchRollLineChartView;


#pragma mark - IBActions
- (IBAction)startRecordingButtonPressed:(id)sender;
- (IBAction)stopRecordingButtonPressed:(id)sender;

@end