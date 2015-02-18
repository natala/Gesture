//
//  NZFrequencyTestVC.h
//  Gesture
//
//  Created by Natalia Zarawska 2 on 2/18/15.
//  Copyright (c) 2015 TUM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NZSensorDataRecordingManager.h"

@interface NZFrequencyTestVC : UIViewController <NZSensorDataRecordingManagerObserver>


@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UILabel *noRecordedSamplesl;
@property (weak, nonatomic) IBOutlet UILabel *frequency;


- (IBAction)startRecordingTapped:(UIButton *)sender;

@end
