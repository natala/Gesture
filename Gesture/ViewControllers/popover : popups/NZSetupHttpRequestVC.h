//
//  NZSetupHttpRequestVC.h
//  Gesture
//
//  Created by Natalia Zarawska on 7/21/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NZSetupHttpRequestVC : UIViewController


#pragma mark - UI elements
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;

@property (weak, nonatomic) IBOutlet UITextField *messageBodyTextField;

@end
