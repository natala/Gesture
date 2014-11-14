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
#import "NZArduinoCommunicationManager.h"

@interface NZMasterMenuTVC : UITableViewController <UISplitViewControllerDelegate, NZStartScreenVCDelegate,NZArduinoCommunicationManagerObserver>

@property (nonatomic, strong) NZStartScreenVC *startScreenVc;

#pragma mark - UI elements
@property (weak, nonatomic) IBOutlet UINavigationItem *connectionStatusNavigationItem;


#pragma mark - cells
@property (weak, nonatomic) IBOutlet UITableViewCell *configureCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *leaveCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *mainControlCell;




@end
