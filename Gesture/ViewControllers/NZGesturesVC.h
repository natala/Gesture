//
//  NZGesturesVC.h
//  Gesture
//
//  Created by Natalia Zarawska on 7/15/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NZPopupViewController.h"
#import "NZGestureSet.h"

@interface NZGesturesVC : UITableViewController </*NSFetchedResultsControllerDelegate,*/ NZPopupViewControllerDelegate>

/**
 * the sensor data set for which the gestures will be displayed
 */
@property (nonatomic, strong) NZGestureSet *gestureSet;

@end
