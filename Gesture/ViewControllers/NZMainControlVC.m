//
//  NZMainControlVC.m
//  Gesture
//
//  Created by Natalia Zarawska on 7/18/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZMainControlVC.h"
#import "NZPipelineController.h"
#import "NZClassLabel+CoreData.h"
#import "NZGesture+CoreData.h"
#import "NZSingleAction.h"
#import "NZActionComposite.h"
#import "NZActionController.h"
#import "NZSensorDataSet.h"
#import "NZGesture.h"
#import "NZCoreDataManager.h"
#import "NZLocation+CoreData.h"

@interface NZMainControlVC ()

//@property NSString *httpRequest;
@property BOOL isSingleMode;
@property (nonatomic, retain) NSString *lastRecognizedGesture;
@property BOOL isRecordingGesture;

@property (nonatomic)  BOOL recordingManagerIsConnected;
@property (nonatomic)  BOOL actionManagerIsReady;

@property (nonatomic) NZLocation *selectedLocation;

@property (nonatomic, retain) UIAlertController *notConnectedAllert;
//@property (nonatomic, retain) UIAlertController *alertController;
//@property (nonatomic, retain) UIAlertController *disconnectedAllertController;
//@property BOOL ringDisconnected;

@property (nonatomic, retain) UIPopoverController *feedbackPopover;

@property (nonatomic, retain) NZSensorDataSet *lastSensorDataSet;

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
    NSArray *allLocations = [NZLocation findAllSortedByName];
    if ([allLocations count] > 0) {
        self.selectedLocation = [allLocations objectAtIndex:0];
    }
   
    self.isRecordingGesture = false;
    self.actionManagerIsReady = false;
    self.recordingManagerIsConnected = false;
    
    //self.httpRequest = @"http://192.168.1.105/api/newdeveloper/lights/2/state";
    // Do any additional setup after loading the view.
    self.notConnectedAllert = [UIAlertController alertControllerWithTitle:@"Connect Power Ring" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
   // [[NZArduinoCommunicationManager sharedManager]addArduinoCommunicationObserver:self];
    [[NZBeanConnectionManager sharedManager] addBeanConnectionObserver:self];
    if (![[NZBeanConnectionManager sharedManager] isConnected]) {
        [[NZBeanConnectionManager sharedManager] connect];
    }
    [[NZBeanConnectionManager sharedManager] startListeningToRing];
    /*self.alertController = [UIAlertController alertControllerWithTitle:@"Connect to the PowerRing" message:@"Make sure the PowerRing is turned on" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Connect" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self startButtonTapped:self.startButton];
        NSLog(@"trying to connect");
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    [self.alertController addAction:action];
    [self.alertController addAction:cancelAction];
    
    self.disconnectedAllertController = [UIAlertController alertControllerWithTitle:@"PowerRing disconnected" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [self.disconnectedAllertController addAction:okAction];
     */
   // self.ringDisconnected = ture;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.isSingleMode = YES;
    if (self.isSingleMode) {
        self.singleGroupSegmentControl.selectedSegmentIndex = 0;
    } else {
        self.singleGroupSegmentControl.selectedSegmentIndex = 1;
    }
   // self.stopStartGestureButton.enabled = false;
    //self.notConnectedLabel.hidden = false;
   // [self startButtonTapped:self.startButton];
    
    if (![[NZActionController sharedManager].observers containsObject:self]) {
        [[NZActionController sharedManager] addObserver:self];
    }
    [[NZActionController sharedManager] prepareAllActionsForExecution];
    
   /* if ([[NZArduinoCommunicationManager sharedManager] isConnected]) {
        [self setupMainControl];
    }*/
    if (![[NZBeanConnectionManager sharedManager] isConnected]) {
        [[NZBeanConnectionManager sharedManager] connect];
    }
    
    [self setupMainControl];
    [[NZBeanConnectionManager sharedManager] startListeningToRing];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
   // [self stopButtonTapped:self.stopButton];
    
    [[NZSensorDataRecordingManager sharedManager] removeRecordingObserver:self];
    if (self.startButton.selected) {
        [[NZSensorDataRecordingManager sharedManager] stopRecordingCurrentSensorDataSet];
    }
   // [[NZSensorDataRecordingManager sharedManager] disconnect];
    
    
    [[NZActionController sharedManager] disconnectActions];
    [[NZActionController sharedManager] removeObserver:self];
    [[NZBeanConnectionManager sharedManager] removeBeanConnectionObserver:self];
    [[NZBeanConnectionManager sharedManager] stopListeningToRing];
    //self.stopStartGestureButton.enabled = false;
    //self.notConnectedLabel.hidden = false;
}

- (void)readyToControl
{
  //  self.stopStartGestureButton.enabled = true;
  //  self.notConnectedLabel.hidden = true;
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

- (void)didReceiveSensorData:(NZSensorData *) sensorData forSensorDataSet:(NZSensorDataSet *) sensorDataSet
{
  //  NSLog(@"Sensor Data Recording Manager did receive sensor data");
}

- (void)didStopRecordingSensorDataSet:(NZSensorDataSet *) sensorDataSet
{
    NSLog(@"Sensor Data Recording Manager did stop recording");
    self.lastSensorDataSet = sensorDataSet;
    // once done, correlate it with the geture as a positive sample
    int classIndex = [[NZPipelineController sharedManager] classifySensorDataSet:sensorDataSet];
    if (classIndex == -1) {
        NSLog(@"unable to recognise the given gesture");
        self.recognizedGestureNameLabel.text = @"Recognized label";
        self.executedActionLabel.text = @"Executed action";
        self.lastRecognizedGesture = nil;
        return;
    }
    
    NZGesture *gesture = [NZGesture findGestureWithIndex:[NSNumber numberWithInt:classIndex]];
    if (!gesture) {
        self.recognizedGestureNameLabel.text = [NSString stringWithFormat:@"%d",classIndex ];
    } else {
        self.recognizedGestureNameLabel.text = gesture.label.name;
        self.lastRecognizedGesture = gesture.label.name;
        if (self.isSingleMode) {
          //  self.executedActionLabel.text = gesture.singleAction.name;
        } else self.executedActionLabel.text = nil;// gesture.actionComposite.name;
    }
    
    /*
    // perform the http request
    if (!gesture.httpRequestMessageBody && !gesture.httpRequestUrl) {
        NSLog(@"no action is defined for this gesture");
        return;
    }
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString: gesture.httpRequestUrl]];
    NSString *jsonString = gesture.httpRequestMessageBody;
    [self sendRequest:request withJson:jsonString];
     */
    if (self.isSingleMode) {
        [[NZActionController sharedManager] executeGesture:gesture withMode:SINGLE_MODE forLocation:self.selectedLocation.name];
    } else [[NZActionController sharedManager] executeGesture:gesture withMode:GROUP_MODE forLocation:self.selectedLocation.name];
    
#warning TODO implement the adding as a positive sample if the user doesn't complain
}

- (void)connected
{
    self.recordingManagerIsConnected = true;
   // [self.alertController dismissViewControllerAnimated:YES completion:nil];
   // self.stopStartGestureButton.enabled = true;
   // self.notConnectedLabel.hidden = true;
    
    
}

- (void)disconnected
{
    self.recordingManagerIsConnected = false;
    self.stopStartGestureButton.enabled = false;
   // self.notConnectedLabel.hidden = false;
    
    // automatically trying to reconnect
   // self.ringDisconnected = true;
    [self startButtonTapped:self.startButton];
}

- (void)buttonStateDidChangeFrom:(ButtonState)previousState to:(ButtonState)currentButtonState
{
    [NZBeanConnectionManager sharedManager].time3 = [NSDate date];
    if (!self.stopStartGestureButton.enabled) {
        NSLog(@"cannot start recording gesture! First tap the start button!");
        return;
    }
    if (self.isRecordingGesture && currentButtonState == BUTTON_SHORT_PRESS) {
        [[NZSensorDataRecordingManager sharedManager] stopRecordingCurrentSensorDataSet];
        self.stopStartGestureButton.highlighted = false;
        self.isRecordingGesture = false;
    } else if (!self.isRecordingGesture && currentButtonState == BUTTON_SHORT_PRESS) {
        
        NSTimeInterval execTime = [[NZBeanConnectionManager sharedManager].time3 timeIntervalSinceDate:[NZBeanConnectionManager sharedManager].time2];
        NSTimeInterval execTime2 = [[NZBeanConnectionManager sharedManager].time2 timeIntervalSinceDate:[NZBeanConnectionManager sharedManager].time0];
        
        [[NZSensorDataRecordingManager sharedManager] startRecordingNewSensorDataSet];
        
        self.stopStartGestureButton.highlighted = true;
        self.isRecordingGesture = true;
    } else if (!self.isRecordingGesture && currentButtonState == BUTTON_DOUBLE_PRESS) {
        self.isSingleMode = !self.isSingleMode;
        if (self.isSingleMode) {
            self.singleGroupSegmentControl.selectedSegmentIndex = 0;
        } else self.singleGroupSegmentControl.selectedSegmentIndex = 1;
        
    } else if (!self.isRecordingGesture && currentButtonState == BUTTON_LONG_PRESS) {
        [[NZActionController sharedManager] undoLastExecution];
        self.debugMessageLabel.text = @"undo";
        [self undoAction];
    } else if (self.isRecordingGesture && currentButtonState == BUTTON_LONG_PRESS) {
        NSLog(@"First stop recording gesture before changing between single and group!");
    }
}

#pragma mark - HTTPP request helpers
- (void)sendRequest:(NSMutableURLRequest *)request withJson:(NSString *)jsonString
{
    NSData *requestData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPMethod:@"PUT"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:requestData];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (connection) {
        NSLog(@"did setup connection");
    }
}

#pragma mark - IBActions

- (IBAction)startButtonTapped:(id)sender
{
   /* if (self.ringDisconnected) {
        if (![self.disconnectedAllertController isBeingPresented]) {
            [self presentViewController:self.disconnectedAllertController animated:YES completion:nil];
        }
    } else {
        if (![self.alertController isBeingPresented]) {
            [self presentViewController:self.alertController animated:YES completion:nil];
        }
    }
    */
   // self.ringDisconnected = false;
    //[self.activityIndicatorView startAnimating];
    
    /*if (![[NZActionController sharedManager].observers containsObject:self]) {
        [[NZActionController sharedManager] addObserver:self];
    }
    if (![[NZSensorDataRecordingManager sharedManager].sensorDataRecordingObservers containsObject:self]) {
        [[NZSensorDataRecordingManager sharedManager] addRecordingObserver:self];
    }
    [[NZActionController sharedManager] prepareAllActionsForExecution];
    
    //BOOL startedNewRecording = [[NZSensorDataRecordingManager sharedManager] startRecordingNewSensorDataSet];
    
    BOOL readyForRecording = [[NZSensorDataRecordingManager sharedManager] prepareForRecordingSensorDataSet];
     */
}

- (IBAction)stopButtonTapped:(id)sender {
   /* [[NZSensorDataRecordingManager sharedManager] removeRecordingObserver:self];
    if (self.startButton.selected) {
        [[NZSensorDataRecordingManager sharedManager] stopRecordingCurrentSensorDataSet];
    }
    [[NZSensorDataRecordingManager sharedManager] disconnect]; */
   /*
    self.startButton.enabled = true;
    self.stopButton.enabled = false;
    self.stopStartGestureButton.enabled = false;
    self.notConnectedLabel.hidden = false;
    */
    /*[[NZActionController sharedManager] disconnectActions];
    [[NZActionController sharedManager] removeObserver:self]; */
}

- (IBAction)singleGroupModeChanged:(id)sender {
}

/*
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
*/
- (IBAction)startStopGestureTouchDown:(id)sender {
    [[NZSensorDataRecordingManager sharedManager] startRecordingNewSensorDataSet];
}

- (IBAction)startStopGestureTouchUpInside:(id)sender {
    [[NZSensorDataRecordingManager sharedManager] stopRecordingCurrentSensorDataSet];
}

#pragma mark - NZActionConntroller Observer methods
- (void)didPrepareAllActionsForExecution
{
    self.actionManagerIsReady = true;
}

- (void)didExecuteAction:(NZAction *)action
{
     self.debugMessageLabel.text = [NSString stringWithFormat: @"executed: %@",action.name];
    NSLog(@"did execute action %@", action.name);
}

- (void)didFailToExecuteAction:(NZAction *)action withErrorMessage:(NSString *)errorMessage
{
    self.debugMessageLabel.text = [NSString stringWithFormat: @"%@ failed with error: %@",action.name, errorMessage];
    NSLog(@"did fail to execute action %@ with error message: %@",action.name, errorMessage);
}

- (void)didLooseConnectionForAction:(NZAction *)action
{
     self.debugMessageLabel.text = [NSString stringWithFormat: @"%@ lost connection",action.name];
    NSLog(@"action %@ lost connection", action.name);
   // self.actionManagerIsReady = false;
}

#pragma mark - setters & getters
- (void)setRecordingManagerIsConnected:(BOOL)recordingManagerIsConnected
{
    _recordingManagerIsConnected = recordingManagerIsConnected;
    if (self.actionManagerIsReady && self.recordingManagerIsConnected) {
        [self readyToControl];
    }
}

- (void)setActionManagerIsReady:(BOOL)actionManagerIsReady
{
    _actionManagerIsReady = actionManagerIsReady;
    if (self.actionManagerIsReady && self.recordingManagerIsConnected) {
        [self readyToControl];
    }
}

#pragma mark - UIAlert View Delegate methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}

- (void)alertViewCancel:(UIAlertView *)alertView
{
    [self stopButtonTapped:self.stopButton];
}

#pragma mark - Helper Methods
- (void)undoAction
{
    // undo
    [[NZActionController sharedManager] undoLastExecution];
    
    // ask for feedback
    if (!self.feedbackPopover) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"FeedbackVc"];
        self.feedbackPopover = [[UIPopoverController alloc] initWithContentViewController:vc];
        if ([vc isKindOfClass:[NZFeedbackVC class]]) {
            NZFeedbackVC *feedbackVc = (NZFeedbackVC *)vc;
            feedbackVc.delegate = self;
        }
    }
    
    CGRect rect = CGRectMake(425, 60, 10, 10);
    [self.feedbackPopover presentPopoverFromRect:rect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUnknown animated:YES];
}

- (void)addSensorDataSet:(NZSensorDataSet *)sensorSet toGesture:(NZGesture *)gesture
{
    [gesture addPositiveSamplesObject:sensorSet];
    // update the database
    [[NZCoreDataManager sharedManager] save];
    
    // update the classifier with the new sample
    if ([sensorSet.sensorData count] > 0) {
        [[NZPipelineController sharedManager] addPositive:YES sample:sensorSet withLabel:gesture.label];
    }

}

#pragma mark - NZ Feedback VC Delegate
- (void)shouldDismissVc:(UIViewController *)vc withAndCorrectRecognition:(BOOL)shouldCorrect
{
    if ([self.presentedViewController isEqual:vc]) {
        [self dismissViewControllerAnimated:YES completion:NO];
    }
    if (shouldCorrect && [vc isKindOfClass:[NZFeedbackVC class]]) {
        NZFeedbackVC *feedbackVc = (NZFeedbackVC *)vc;
        [self addSensorDataSet:self.lastSensorDataSet toGesture:feedbackVc.correctGesture];
        self.lastSensorDataSet = nil;
    }
}

#pragma mark - Bean Connection Manager Observer methids

- (void)beanConnectionManagerDidConnected
{
    [self setupMainControl];
}

- (void)beanConnectionManagerDidDisconnectConnect
{
    if (![self.notConnectedAllert isBeingPresented]) {
        [self presentViewController:self.notConnectedAllert animated:YES completion:nil];
    }
    
    self.stopStartGestureButton.highlighted = false;
    self.stopStartGestureButton.enabled = false;
    self.notConnectedLabel.hidden = false;
}

#pragma mark - Arduino Connection Manager Observer methods
/*
- (void)arduinoCommunicationManagerDidDisconnectConnect{
    if (![self.notConnectedAllert isBeingPresented]) {
        [self presentViewController:self.notConnectedAllert animated:YES completion:nil];
    }
    
    self.stopStartGestureButton.highlighted = false;
    self.stopStartGestureButton.enabled = false;
    self.notConnectedLabel.hidden = false;
}

- (void)arduinoCommunicationManagerDidConnect {
    [self setupMainControl];
}
*/
#pragma mark - helper methods
- (void) setupMainControl
{
    if ([self.notConnectedAllert isBeingPresented]) {
        [self.notConnectedAllert dismissViewControllerAnimated:YES completion:nil];
    }
    
    if ([self isViewLoaded]) {
        if (![[NZSensorDataRecordingManager sharedManager].sensorDataRecordingObservers containsObject:self]) {
            [[NZSensorDataRecordingManager sharedManager] addRecordingObserver:self];
        }
        [[NZActionController sharedManager] prepareAllActionsForExecution];
        BOOL readyForRecording = [[NZSensorDataRecordingManager sharedManager] prepareForRecordingSensorDataSet];
    }
    
    
    //BOOL startedNewRecording = [[NZSensorDataRecordingManager sharedManager] startRecordingNewSensorDataSet];
    
    
    
    self.notConnectedLabel.hidden = true;
    self.stopStartGestureButton.enabled = true;
}

@end
