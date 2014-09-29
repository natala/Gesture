//
//  NZConfigurationNavigationController.h
//  Gesture
//
//  Created by Natalia Zarawska on 9/26/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NZConfigurationNavigationController : UINavigationController <UINavigationControllerDelegate>

/**
 * pops to the root VC and presents the actions configuration VC
 */
- (void)switchFromGesturesToActions;

/**
 * pops to the root VC and presents the gestures configuration VC
 */
- (void)switchFromActionsToGestures;

@end
