//
//  NZPipelineConfigurationVC.m
//  Gesture
//
//  Created by Natalia Zarawska on 7/19/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZPipelineConfigurationVC.h"
#import "NZPipelineController.h"

@interface NZPipelineConfigurationVC ()

@end

@implementation NZPipelineConfigurationVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
    self.successLabel.text = @"";
    self.numberOfClassesLabel.text = [NSString stringWithFormat:@"#classes: %d", [[NZPipelineController sharedManager] numberOfClasses]];
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

- (IBAction)retrainButtonTapped:(id)sender {
    
    if ([[NZPipelineController sharedManager] trainClassifier]) {
        self.successLabel.text = @"success";
    } else {
        self.successLabel.text = @"fail";
    }
    self.numberOfClassesLabel.text = [NSString stringWithFormat:@"#classes: %d", [[NZPipelineController sharedManager] numberOfClasses]];
}
@end
