//
//  NZGestureActionMappingVC.h
//  Gesture
//
//  Created by Natalia Zarawska on 9/26/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NZGesture+CoreData.h"

@interface NZGestureActionMappingVC : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (retain ,nonatomic) NZGesture *selectedGesture;

#pragma mark - IBActions
- (IBAction)moreButtonTapped:(UIButton *)sender;


@end
