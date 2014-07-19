//
//  NZPipelineConfigurationVC.h
//  Gesture
//
//  Created by Natalia Zarawska on 7/19/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NZPipelineConfigurationVC : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *successLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfClassesLabel;

- (IBAction)retrainButtonTapped:(id)sender;

@end
