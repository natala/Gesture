//
//  NZStartScreenVC.h
//  Gesture
//
//  Created by Natalia Zarawska on 9/10/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NZStartScreenVC;

@protocol NZStartScreenVCDelegate <NSObject>

@required
- (void)startScreen:(NZStartScreenVC *)startScreen didSelectGestureSet:(NSString *)gestureSetName;

@end

@interface NZStartScreenVC : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) id<NZStartScreenVCDelegate> delegate;

#pragma mark - UI Elements
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

#pragma mark - IB Actions
- (IBAction)goButtonTapped:(UIButton *)sender;

@end
