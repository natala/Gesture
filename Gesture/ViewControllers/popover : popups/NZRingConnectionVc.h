//
//  NZRingConnectionVc.h
//  Gesture
//
//  Created by Natalia Zarawska on 11/12/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NZRingConnectionVc : UIViewController

@property (nonatomic, retain) NSString * connectionStatusText;

#pragma mark - UI Elements
@property (weak, nonatomic) IBOutlet UILabel *connectionStatusLabel;


@end
