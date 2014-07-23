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

@interface NZMainControlVC ()

//@property NSString *httpRequest;
@property BOOL isSingleMode;
@property (nonatomic, retain) NSString *lastRecognizedGesture;

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
    //self.httpRequest = @"http://192.168.1.105/api/newdeveloper/lights/2/state";
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
    self.startButton.enabled = ![[NZSensorDataRecordingManager sharedManager] isConnected];
    self.stopButton.enabled = !self.startButton.enabled;
    self.isSingleMode = YES;
    if (self.isSingleMode) {
        [self.singleGroupSegmentControl setEnabled:false forSegmentAtIndex:1];
       // [self.singleGroupSegmentControl setEnabled:true forSegmentAtIndex:2];
    } else {
      //  [self.singleGroupSegmentControl setEnabled:true forSegmentAtIndex:1];
        [self.singleGroupSegmentControl setEnabled:false forSegmentAtIndex:2];
    }
    self.stopStartGestureButton.enabled = !self.startButton.enabled;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
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
    int classIndex = [[NZPipelineController sharedManager] classifySensorDataSet:sensorDataSet];
    if (classIndex == -1) {
        NSLog(@"unable to recognise the given gesture");
        self.recognizedGestureNameLabel.text = @"Recognized label";
        self.lastRecognizedGesture = nil;
        return;
    }
    
   // NZClassLabel *classLabel = [NZClassLabel findEntitiesWithIndex:[NSNumber numberWithInt:classIndex]];
    NZGesture *gesture = [NZGesture findGestureWithIndex:[NSNumber numberWithInt:classIndex]];
    if (!gesture) {
        self.recognizedGestureNameLabel.text = [NSString stringWithFormat:@"%d",classIndex ];
    } else {
        self.recognizedGestureNameLabel.text = gesture.label.name;
        self.lastRecognizedGesture = gesture.label.name;
    }
    
    // perform the http request
    if (!gesture.httpRequestMessageBody && !gesture.httpRequestUrl) {
        NSLog(@"no action is defined for this gesture");
        return;
    }
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString: gesture.httpRequestUrl]];
    NSString *jsonString = gesture.httpRequestMessageBody;
    [self sendRequest:request withJson:jsonString];
    
#warning TODO implement the adding as a positive sample if the user doesn't complain
}

- (void)connected
{

}

- (void)disconnected
{
    self.startButton.enabled = true;
    self.stopButton.enabled = false;
    self.stopStartGestureButton.enabled = false;
}

#pragma mark - HTTPP request helpers
- (void)sendRequest:(NSMutableURLRequest *)request withJson:(NSString *)jsonString
{
    NSData *requestData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPMethod:@"PUT"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:requestData];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (connection) {
        NSLog(@"did setup connection");
    }
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
    if (self.startButton.selected) {
        [[NZSensorDataRecordingManager sharedManager] stopRecordingCurrentSensorDataSet];
    }
    [[NZSensorDataRecordingManager sharedManager] disconnect];
    self.startButton.enabled = true;
    self.stopButton.enabled = false;
    self.stopStartGestureButton.enabled = false;
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
@end
