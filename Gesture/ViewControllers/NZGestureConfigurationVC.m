//
//  NZGestureConfigurationVC.m
//  Gesture
//
//  Created by Natalia Zarawska on 7/17/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZGestureConfigurationVC.h"

@interface NZGestureConfigurationVC ()

@end

@implementation NZGestureConfigurationVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.startGestureButton.enabled = true;
    self.stopGestureButton.enabled = false;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - IBActions

- (IBAction)startGestureTapped:(id)sender {
    [[NZSensorDataRecordingManager sharedManager] addRecordingObserver:self];
    BOOL startedNewRecording = [[NZSensorDataRecordingManager sharedManager] startRecordingNewSensorDataSet];
    if (startedNewRecording) {
        self.startGestureButton.enabled = false;
        self.stopGestureButton.enabled = true;
    }
}
- (IBAction)stopGestureTapped:(id)sender {
    [[NZSensorDataRecordingManager sharedManager] stopRecordingCurrentSensorDataSet];
    self.stopGestureButton.enabled = false;
    self.startGestureButton.enabled = true;
}

#pragma mark - Sensor Data Recording Manager Observer methods

- (void)didStartRecordingSensorData:(NZSensorDataSet *) sensorDataSet
{
    
}

- (void)didPauseReordingSensorData:(NZSensorDataSet *) sensorDataSet
{

}

- (void)didResumeRecordingSensorData:(NZSensorDataSet *) sensorDataSet
{

}

- (void)didReceiveSensorData:(NZSensorData *) sensorData forSensorDataSer:(NZSensorDataSet *) sensorDataSet
{

}

- (void)didStopRecordingSensorDataSet:(NZSensorDataSet *) sensorDataSet
{

}

@end
