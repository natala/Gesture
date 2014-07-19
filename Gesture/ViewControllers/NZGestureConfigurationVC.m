//
//  NZGestureConfigurationVC.m
//  Gesture
//
//  Created by Natalia Zarawska on 7/17/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZGestureConfigurationVC.h"
#import "NZCoreDataManager.h"
#import "NZPipelineController.h"

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
    if (([self.gesture.positiveSamples count] > 0) || ([self.gesture.negativeSamples count] > 0)) {
        self.learnGestureButton.enabled = true;
    }
    self.learnGestureButton.enabled = false;
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
        self.learnGestureButton.enabled = false;
    }
}
- (IBAction)stopGestureTapped:(id)sender {
    [[NZSensorDataRecordingManager sharedManager] stopRecordingCurrentSensorDataSet];
    self.stopGestureButton.enabled = false;
    self.startGestureButton.enabled = true;
    if (([self.gesture.positiveSamples count] > 0) || ([self.gesture.negativeSamples count] > 0)) {
        self.learnGestureButton.enabled = true;
    }
}

- (IBAction)learnGestureTapped:(id)sender {
    [[NZPipelineController sharedManager] trainClassifier];

}

#pragma mark - Sensor Data Recording Manager Observer methods

- (void)didStartRecordingSensorData:(NZSensorDataSet *) sensorDataSet
{
    NSLog(@"Sensor Data Recording Manager did start recording");
}

- (void)didPauseReordingSensorData:(NZSensorDataSet *) sensorDataSet
{
    NSLog(@"Sensor Data Recording Manager did stop recording");
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
    // once done, correlate it find with the geture as a positive sample
    [self.gesture addPositiveSamplesObject:sensorDataSet];
    
    
    // update the database
    NSManagedObjectContext *context = [[NZCoreDataManager sharedManager] managedObjectContext];
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    // update the classifier with the new sample
    [[NZPipelineController sharedManager] addPositive:YES sample:sensorDataSet withLabel:self.gesture.label];
}

@end
