//
//  NZMasterMenuTVC.h
//  Gesture
//
//  Created by Natalia Zarawska on 6/26/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NZStartScreenVC.h"
#import "NZStartScreenVC.h"

@interface NZMasterMenuTVC : UITableViewController <UISplitViewControllerDelegate, NZStartScreenVCDelegate>

@property (nonatomic, weak) NZStartScreenVC *startScreenVc;

#pragma mark - cells
@property (weak, nonatomic) IBOutlet UITableViewCell *ringConnectionCell;


@end
