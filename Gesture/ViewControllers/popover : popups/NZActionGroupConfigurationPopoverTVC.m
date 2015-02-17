//
//  NZActionGroupConfigurationPopoverTVTableViewController.m
//  Gesture
//
//  Created by Natalia Zarawska on 11/13/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZActionGroupConfigurationPopoverTVC.h"
#import "NZSingleAction+CoreData.h"
#import "NZAction.h"
#import "NZLocation.h"
#import "NZCoreDataManager.h"

@interface NZActionGroupConfigurationPopoverTVC ()

@property (nonatomic, retain) NSMutableArray *ownedActions;
@property (nonatomic, retain) NSMutableArray *notOwnedActions;

@end

@implementation NZActionGroupConfigurationPopoverTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.groupNameLabel.text = self.groupAction.name;
  //  UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognized:)];
  //  [self.tableView addGestureRecognizer:longPress];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Actions in the group";
    } else return @"Other possible actions";
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [self.ownedActions count];
    }
    if (section == 1) {
        return [self.notOwnedActions count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"actionCell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"actionCell"];
    }
    NZSingleAction *action;
    if (indexPath.section == 0) {
        action = [self.ownedActions objectAtIndex:indexPath.row];
    } else {
        action = [self.notOwnedActions objectAtIndex:indexPath.row];
    }
    cell.textLabel.text = action.name;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5.0;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    if (sourceIndexPath.section != destinationIndexPath.section) {
        if (destinationIndexPath.section == 0) {
            NZSingleAction *action = [self.notOwnedActions objectAtIndex:sourceIndexPath.row];
            [self.ownedActions addObject:action];
            [self.notOwnedActions removeObject:action];
            [self.groupAction addChildActionsObject:action];
        } else {
            NZSingleAction *action = [self.ownedActions objectAtIndex:sourceIndexPath.row];
            [self.notOwnedActions addObject:action];
            [self.ownedActions removeObject:action];
            [self.groupAction removeChildActionsObject:action];
        }
      //  [[NZCoreDataManager sharedManager] save];
    }
}

#pragma mark - Table View Delegate

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Gesture Recognizer methods
/*
- (IBAction)longPressGestureRecognized:(id)sender {
    
    UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender;
    UIGestureRecognizerState state = longPress.state;
    
    CGPoint location = [longPress locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    
    static UIView       *snapshot = nil;        ///< A snapshot of the row user is moving.
    static NSIndexPath  *sourceIndexPath = nil; ///< Initial index path, where gesture begins.
    
    switch (state) {
        case UIGestureRecognizerStateBegan: {
            if (indexPath) {
                sourceIndexPath = indexPath;
                
                UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
                
                // Take a snapshot of the selected row using helper method.
                snapshot = [self customSnapshotFromView:cell];
                
                // Add the snapshot as subview, centered at cell's center...
                __block CGPoint center = cell.center;
                snapshot.center = center;
                snapshot.alpha = 0.0;
                [self.tableView addSubview:snapshot];
                [UIView animateWithDuration:0.25 animations:^{
                    
                    // Offset for gesture location.
                    center.y = location.y;
                    snapshot.center = center;
                    snapshot.transform = CGAffineTransformMakeScale(1.05, 1.05);
                    snapshot.alpha = 0.98;
                    
                    // Fade out.
                    cell.alpha = 0.0;
                    
                } completion:^(BOOL finished) {
                    
                    cell.hidden = YES;
                    
                }];
            }
        }
        case UIGestureRecognizerStateChanged: {
            CGPoint center = snapshot.center;
            center.y = location.y;
            snapshot.center = center;
            
            // Is destination valid and is it different from source?
            if (indexPath && ![indexPath isEqual:sourceIndexPath]) {
                
                // ... update data source.
                [self.objects exchangeObjectAtIndex:indexPath.row withObjectAtIndex:sourceIndexPath.row];
                
                // ... move the rows.
                [self.tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:indexPath];
                
                // ... and update source so it is in sync with UI changes.
                sourceIndexPath = indexPath;
            }
        }
        default: {
            // Clean up.
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:sourceIndexPath];
            cell.hidden = NO;
            cell.alpha = 0.0;
            [UIView animateWithDuration:0.25 animations:^{
                
                snapshot.center = cell.center;
                snapshot.transform = CGAffineTransformIdentity;
                snapshot.alpha = 0.0;
                
                // Undo fade out.
                cell.alpha = 1.0;
                
            } completion:^(BOOL finished) {
                
                sourceIndexPath = nil;
                [snapshot removeFromSuperview];
                snapshot = nil;
                
            }];
            break;
        }
    }
}
*/
- (UIView *)customSnapshotFromView:(UIView *)inputView {
    UIView *snapshot = [inputView snapshotViewAfterScreenUpdates:YES];
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.4;
    
    return snapshot;
}
            
#pragma mark - setters & getters
- (void)setGroupAction:(NZActionComposite *)groupAction
{
    _groupAction = groupAction;
    self.ownedActions = [NSMutableArray arrayWithArray: [groupAction.childActions allObjects]];
    self.notOwnedActions = [NSMutableArray arrayWithArray: [NZSingleAction findAllSortedByNameActionsForLocation:groupAction.location.name] ];
    [self.notOwnedActions removeObjectsInArray:self.ownedActions];
}

#pragma mark - IB Actions
    
- (IBAction)editButtonTapped:(UIButton *)sender {
    if ([self.tableView isEditing]) {
        [self.tableView setEditing:NO animated:YES];
        [self.editButton setTitle:@"Edit" forState:UIControlStateNormal];
    } else {
        [self.tableView setEditing:YES animated:YES];
        [self.editButton setTitle:@"Done" forState:UIControlStateNormal];
    }
}

- (IBAction)closeButtonTapped:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
