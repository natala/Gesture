//
//  NZMainControlVC.m
//  Gesture
//
//  Created by Natalia Zarawska on 7/18/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZMainControlVC.h"
#import "NZPipelineController.h"
#import "NZClassLabel.h"

@interface NZMainControlVC ()

@end

@implementation NZMainControlVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.startButton.enabled = true;
    self.stopButton.enabled = false;
    [self.singleGroupSegmentControl setEnabled:false forSegmentAtIndex:1];
    self.stopStartGestureButton.enabled = false;
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

#pragma mark - Sensor Data Recording Manager Observer methods

- (void)didStartRecordingSensorData:(NZSensorDataSet *) sensorDataSet
{
    NSLog(@"Sensor Data Recording Manager did start recording");
}

- (void)didPauseReordingSensorData:(NZSensorDataSet *) sensorDataSet
{
    NSLog(@"Sensor Data Recording Manager did pause recording");
}

- (void)didResumeRecordingSensorData:(NZSensorDataSet *) sensorDataSet
{
    //NSLog(@"Sensor Data Recording Manager did resume recording");
}

- (void)didReceiveSensorData:(NZSensorData *) sensorData forSensorDataSer:(NZSensorDataSet *) sensorDataSet
{
    NSLog(@"Sensor Data Recording Manager did receive sensor data");
}

- (void)didStopRecordingSensorDataSet:(NZSensorDataSet *) sensorDataSet
{
    NSLog(@"Sensor Data Recording Manager did stop recording");
    // once done, correlate it with the geture as a positive sample
    int classLabel = [[NZPipelineController sharedManager] classifySensorDataSet:sensorDataSet];
    if (classLabel == -1) {
        NSLog(@"unable to recognise the given gesture");
        self.recognizedGestureNameLabel.text = @"Recognized label";
        return;
    }
    self.recognizedGestureNameLabel.text = [NSString stringWithFormat:@"%d",classLabel ];
    
#warning TODO implement the adding as a positive sample if the user doesn't complain
}


#pragma mark - IBActions

- (IBAction)startButtonTapped:(id)sender
{
    [[NZSensorDataRecordingManager sharedManager] addRecordingObserver:self];
    //BOOL startedNewRecording = [[NZSensorDataRecordingManager sharedManager] startRecordingNewSensorDataSet];
    BOOL readyForRecording = [[NZSensorDataRecordingManager sharedManager] prepareForRecordingSensorDataSet];
    
    if (readyForRecording) {
        self.startButton.enabled = false;
        self.stopButton.enabled = true;
        self.stopStartGestureButton.enabled = true;
    }
    
}

- (IBAction)stopButtonTapped:(id)sender {
    [[NZSensorDataRecordingManager sharedManager] removeRecordingObserver:self];
    self.startButton.enabled = true;
    self.stopButton.enabled = false;
    if (self.startButton.selected) {
        [[NZSensorDataRecordingManager sharedManager] stopRecordingCurrentSensorDataSet];
    }
    [[NZSensorDataRecordingManager sharedManager] disconnect];
    self.stopStartGestureButton.selected = false;
    self.stopStartGestureButton.enabled = false;
}

- (IBAction)singleGroupModeChanged:(id)sender {
}

- (IBAction)startStopGestureTapped:(id)sender
{
    BOOL isRecording = self.stopStartGestureButton.selected;
    if (!isRecording) {
        isRecording = [[NZSensorDataRecordingManager sharedManager] startRecordingNewSensorDataSet];
    } else {
        [[NZSensorDataRecordingManager sharedManager] stopRecordingCurrentSensorDataSet];
        isRecording = false;
    }
    
    [self.stopStartGestureButton setSelected:isRecording];
    
}
@end
