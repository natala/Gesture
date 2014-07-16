//
//  NZPopupViewController.h
//  Gesture
//
//  Created by Natalia Zarawska on 7/15/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NZPopupViewControllerDelegate

@required
/**
 * This method is called whenever all required fields are filled by the user and accepted but the controller
 * @author  Natalia Zarawska
 */
- (void)didFinishFillingFormWithData:(NSDictionary *)form;

@end

@interface NZPopupViewController : UIViewController


@property (nonatomic, retain) id<NZPopupViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *timestampText;


@property (strong, nonatomic) IBOutlet UIView *popUpView;
- (IBAction)doneButtonTapped:(id)sender;

//- (void)showView:(UIView *)aView animated:(BOOL)animated;

@end