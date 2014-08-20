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
#import "NZClassLabel.h"
#import "NZSetupHttpRequestVC.h"
#import "NZEditGestureSamplesTVC.h"

@interface NZGestureConfigurationVC ()

@property (nonatomic, retain) UIPopoverController *popover;
@property (nonatomic, retain) UIPopoverController *gestureSamplesPopover;
@property BOOL isRecordingGesture;

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
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NZSetupHttpRequestVC *httpRequestVc = [storyboard instantiateViewControllerWithIdentifier:@"HttpRequestPopoverVC"];
    self.popover = [[UIPopoverController alloc] initWithContentViewController:httpRequestVc];
    [self.popover setPopoverContentSize:CGSizeMake(700, 300)];
    self.popover.delegate = self;
    
    NZEditGestureSamplesTVC *samplesVC = [storyboard instantiateViewControllerWithIdentifier:@"GestureSamplesTVC"];
    self.gestureSamplesPopover = [[UIPopoverController alloc] initWithContentViewController:samplesVC];
    self.gestureSamplesPopover.delegate = self;
    
    self.isRecordingGesture = false;
    
   // self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editSamplesButtonSelected:)];
    //self.numOfTrainingSamples.text = [NSString stringWithFormat:@"%d", [[NZPipelineController sharedManager] numberOfSamplesForClassLabelIndex:self.gesture.label.index]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //self.samplesButton.titleLabel.text = [NSString stringWithFormat:@"%d samples", [self.gesture.positiveSamples count]];

    self.numOfTrainingSamples.text = [NSString stringWithFormat:@"%d", [[NZPipelineController sharedManager] numberOfSamplesForClassLabelIndex:self.gesture.label.index]];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    BOOL didConnect = [[NZSensorDataRecordingManager sharedManager] prepareForRecordingSensorDataSet];
    if (didConnect) {
        self.startStopRecordingGestureButton.enabled = true;
    }
    if (([self.gesture.positiveSamples count] > 0) || ([self.gesture.negativeSamples count] > 0)) {
        self.learnGestureButton.enabled = true;
    }
     [[NZSensorDataRecordingManager sharedManager] addRecordingObserver:self];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NZSensorDataRecordingManager sharedManager] disconnect];
    [[NZSensorDataRecordingManager sharedManager] removeRecordingObserver:self];
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

- (IBAction)learnGestureTapped:(id)sender {
    [[NZPipelineController sharedManager] trainClassifier];

}

- (IBAction)startStopRecordingGestureButtonTouchDown:(id)sender {
    BOOL startedNewRecording = [[NZSensorDataRecordingManager sharedManager] startRecordingNewSensorDataSet];
    if (startedNewRecording) {
        self.learnGestureButton.enabled = false;
    }
}

- (IBAction)startStopRecordingGestureButtonTouchUpInside:(id)sender {
    [[NZSensorDataRecordingManager sharedManager] stopRecordingCurrentSensorDataSet];
    if (([self.gesture.positiveSamples count] > 0) || ([self.gesture.negativeSamples count] > 0)) {
        self.learnGestureButton.enabled = true;
    }
    
    self.numOfTrainingSamples.text = [NSString stringWithFormat:@"%d", [[NZPipelineController sharedManager] numberOfSamplesForClassLabelIndex:self.gesture.label.index]];
}

- (IBAction)setupHttpRequestButtonTapped:(id)sender {
    NZSetupHttpRequestVC *vc
    = (NZSetupHttpRequestVC *)self.popover.contentViewController;
    if (self.gesture.httpRequestUrl) {
        vc.urlTextField.text = self.gesture.httpRequestUrl;
    } else {
        vc.urlTextField.text = @"http://10.130.108.81/api/newdeveloper/lights/1/state";
    }
    if (self.gesture.httpRequestMessageBody) {
        vc.messageBodyTextField.text = self.gesture.httpRequestMessageBody;
    } else {
        vc.messageBodyTextField.text = @"{\"on\":true, \"br\":255, \"hue\":1000}";
    }
    UIButton *senderButton = (UIButton *)sender;
    [self.popover presentPopoverFromRect:senderButton.bounds inView:senderButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)samplesButtonTapped:(id)sender {
    NZEditGestureSamplesTVC *vc = (NZEditGestureSamplesTVC *)self.gestureSamplesPopover.contentViewController;
    vc.gesture = self.gesture;
    UIButton *senderButton = (UIButton *)sender;
    [self.gestureSamplesPopover presentPopoverFromRect:senderButton.bounds inView:senderButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

#pragma mark - popover controller delegate methods
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    if ([popoverController.contentViewController isKindOfClass:[NZSetupHttpRequestVC class]]) {
        NZSetupHttpRequestVC *vc = (NZSetupHttpRequestVC *)popoverController.contentViewController;
        self.gesture.httpRequestUrl = vc.urlTextField.text;
        self.gesture.httpRequestMessageBody = vc.messageBodyTextField.text;
    
        // update the database
        NSManagedObjectContext *context = [[NZCoreDataManager sharedManager] managedObjectContext];
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    } else if ([popoverController.contentViewController isKindOfClass:[NZEditGestureSamplesTVC class]]) {
        //self.samplesButton.titleLabel.text = [NSString stringWithFormat:@"%d samples", [self.gesture.positiveSamples count]];
        
        // relode the samples for this gesture in the pipeline controller
        if ([self.gesture.positiveSamples count] < [[NZPipelineController sharedManager] numberOfSamplesForClassLabelIndex:self.gesture.label.index] ) {
            [[NZPipelineController sharedManager] removeAllSamplesWithLable:self.gesture.label];
            [[NZPipelineController sharedManager] addPositive:YES samples:[self.gesture.positiveSamples allObjects] withLabel:self.gesture.label];
            self.numOfTrainingSamples.text = [NSString stringWithFormat:@"%d", [[NZPipelineController sharedManager] numberOfSamplesForClassLabelIndex:self.gesture.label.index]];
        }
    }

}

#pragma mark - Sensor Data Recording Manager Observer methods

- (void)disconnected
{
    NSLog(@"The ring disconnected");
    self.startStopRecordingGestureButton.enabled = false;
}

- (void)connected
{
    self.startStopRecordingGestureButton.enabled = true;
}

- (void)didStartRecordingSensorData:(NZSensorDataSet *) sensorDataSet
{
    NSLog(@"Sensor Data Recording Manager did start recording");
}

- (void)didPauseReordingSensorData:(NZSensorDataSet *) sensorDataSet
{
    NSLog(@"Sensor Data Recording Manager did pasue recording");
}

- (void)didResumeRecordingSensorData:(NZSensorDataSet *) sensorDataSet
{
    //NSLog(@"Sensor Data Recording Manager did resume recording");
}

- (void)didReceiveSensorData:(NZSensorData *) sensorData forSensorDataSet:(NZSensorDataSet *) sensorDataSet
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
    if ([sensorDataSet.sensorData count] > 0) {
        [[NZPipelineController sharedManager] addPositive:YES sample:sensorDataSet withLabel:self.gesture.label];
    }
}

- (void)buttonStateDidChangeFrom:(ButtonState)previousState to:(ButtonState)currentButtonState
{
    if (self.isRecordingGesture && currentButtonState == BUTTON_SHORT_PRESS) {
        // stop recording the gesture
        [[NZSensorDataRecordingManager sharedManager] stopRecordingCurrentSensorDataSet];
        if (([self.gesture.positiveSamples count] > 0) || ([self.gesture.negativeSamples count] > 0)) {
            self.learnGestureButton.enabled = true;
        }
        
        self.numOfTrainingSamples.text = [NSString stringWithFormat:@"%d", [[NZPipelineController sharedManager] numberOfSamplesForClassLabelIndex:self.gesture.label.index]];
        self.isRecordingGesture = false;
        self.startStopRecordingGestureButton.highlighted = false;
        
    } else if (!self.isRecordingGesture && currentButtonState == BUTTON_SHORT_PRESS){
        // start recording the gesture
        BOOL startedNewRecording = [[NZSensorDataRecordingManager sharedManager] startRecordingNewSensorDataSet];
        if (startedNewRecording) {
            self.learnGestureButton.enabled = false;
            self.isRecordingGesture = true;
            self.startStopRecordingGestureButton.highlighted = true;
        }
    } else if (!self.isRecordingGesture && currentButtonState == BUTTON_LONG_PRESS) {
        // switch between single and group
        // do I really want to do it here? don't think so.
    }
}

@end
