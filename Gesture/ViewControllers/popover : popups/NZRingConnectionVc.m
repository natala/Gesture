//
//  NZRingConnectionVc.m
//  Gesture
//
//  Created by Natalia Zarawska on 11/12/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZRingConnectionVc.h"

@interface NZRingConnectionVc ()

@end

@implementation NZRingConnectionVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    if (!self.connectionStatusText) {
        self.connectionStatusText = @"is not connected";
    }
    self.connectionStatusLabel.text = self.connectionStatusText;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - getters & setters
- (void)setConnectionStatusText:(NSString *)connectionStatusText
{
    _connectionStatusText = connectionStatusText;
    self.connectionStatusLabel.text = connectionStatusText;
}

@end
