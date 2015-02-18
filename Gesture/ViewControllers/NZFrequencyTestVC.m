//
//  NZFrequencyTestVC.m
//  Gesture
//
//  Created by Natalia Zarawska 2 on 2/18/15.
//  Copyright (c) 2015 TUM. All rights reserved.
//

#import "NZFrequencyTestVC.h"
#import "NZSensorDataSet.h"

@interface NZFrequencyTestVC ()

@end

@implementation NZFrequencyTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)startRecordingTapped:(UIButton *)sender {
    
    [[NZSensorDataRecordingManager sharedManager] addRecordingObserver:self];
    [[NZSensorDataRecordingManager sharedManager] prepareForRecordingSensorDataSet];
    
    [[NZSensorDataRecordingManager sharedManager] startRecordingNewSensorDataSet];
    
    
}

#pragma mark - obserever functions
- (void)didStartRecordingSensorData:(NZSensorDataSet *) sensorDataSet
{
    self.startButton.enabled = false;
    
    double delayInSeconds = 10;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [[NZSensorDataRecordingManager sharedManager] stopRecordingCurrentSensorDataSet];
    });

    NSLog(@"started");
}

- (void)didStopRecordingSensorDataSet:(NZSensorDataSet *) sensorDataSet
{
    self.startButton.enabled = true;
    int sampleLength = [[sensorDataSet.sensorData allObjects] count];
    NSLog(@"stopped with %d samples", sampleLength);
    self.noRecordedSamplesl.text = [NSString stringWithFormat:@"%d", sampleLength];
    self.frequency.text = [NSString stringWithFormat:@"%f", (double)10/sampleLength];

}

//- (void)disconnected;

- (void)connected
{
}

@end
