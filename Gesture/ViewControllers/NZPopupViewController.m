//
//  NZPopupViewController.m
//  Gesture
//
//  Created by Natalia Zarawska on 7/15/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZPopupViewController.h"

@interface NZPopupViewController ()

@end

@implementation NZPopupViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    //self.view.backgroundColor=[[UIColor whiteColor] colorWithAlphaComponent:.3];
    self.popUpView.layer.cornerRadius = 5;
    self.popUpView.layer.shadowOpacity = 0.8;
    self.popUpView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
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


#pragma mark - IBAction methods

- (IBAction)doneButtonTapped:(id)sender {
    
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:self.nameText.text, @"name", nil];
    [self.delegate didFinishFillingFormWithData:dic];
 //   [self removeAnimate];
}

@end
