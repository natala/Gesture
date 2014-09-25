//
//  NZEditGestureSamplesTVC.h
//  Gesture
//
//  Created by Natalia Zarawska on 7/22/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NZGesture+CoreData.h"

@protocol NZEditingGestureSamplesTVCDelegare <NSObject>

- (void)didDeleteSample;

@end

@interface NZEditGestureSamplesTVC : UITableViewController

@property (nonatomic, retain) NZGesture *gesture;
@property (nonatomic, retain) id<NZEditingGestureSamplesTVCDelegare> delegate;

@end
