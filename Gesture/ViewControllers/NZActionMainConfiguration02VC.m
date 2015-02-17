//
//  NZActionMainConfiguration02VC.m
//  Gesture
//
//  Created by Natalia Zarawska on 11/13/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZActionMainConfiguration02VC.h"
#import "NZLocation+CoreData.h"
#import "NZAction+CoreData.h"
#import "NZSingleAction+CoreData.h"
#import "NZActionComposite+CoreData.h"
#import "NZCoreDataManager.h"
#import "NZActionGroupConfigurationPopoverTVC.h"

@interface NZActionMainConfiguration02VC ()

@property (nonatomic, retain) NSArray *allSingleActionsForLocation;
@property (nonatomic, retain) NSArray *allGroupActionsForLocation;
@property (nonatomic, retain) NSArray *allLocations;
@property (nonatomic, retain) NZLocation *selectedLocation;
@property (nonatomic) BOOL singleActions;

#pragma mark - alerts and popovers
@property (retain, nonatomic) UIAlertController *addActionGroupAlertController;
@property (nonatomic, strong) NZActionGroupConfigurationPopoverTVC * configGroupActionTvc;

@end

@implementation NZActionMainConfiguration02VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // add gesture recognizer to enable moving cells
    self.singleActions = true;
    self.allLocations = [NZLocation findAllSortedByName];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ActionGroupsConfigTvc"];
    if ([vc isKindOfClass:[NZActionGroupConfigurationPopoverTVC class]]) {
        self.configGroupActionTvc = (NZActionGroupConfigurationPopoverTVC *)vc;
    }
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if ([self.allLocations count] == 1) {
        self.selectedLocation = [self.allLocations objectAtIndex:0];
    } else if ([self.allLocations count] > 0) {
        for (int i = 0; i < [self.allLocations count]; i++) {
            NZLocation *location = [self.allLocations objectAtIndex:i];
            if ([location.action count] > 0) {
                [self.locationsPickerView selectRow:i inComponent:0 animated:NO];
                self.selectedLocation = [self.allLocations objectAtIndex:i];
                break;
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - UI Picker View Data Source
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.allLocations count];
}

#pragma mark - UI Picker View Delegate

// Setting the dimensions fo the picker view
/*
 - (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
 {}
 */
/*
 - (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
 {}
 */

// Setting the Content of Component Rows
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NZLocation *location = [self.allLocations objectAtIndex:row];
    return location.name;
}

/*
 pickerView:attributedTitleForRow:forComponent:
 pickerView:viewForRow:forComponent:reusingView:
 */

// Responding to Row Selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([self.allLocations count] == 0) {
        return;
    }
    self.selectedLocation = [self.allLocations objectAtIndex:row];
}

#pragma mark - UI Table View Data Source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (self.singleActions) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"singleActionCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"singleActionCell"];
        }
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"compositeActionCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"compositeActionCell"];
        }
    }
    
    [self configureCell:cell atIdexPath:indexPath];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = 0;
    if (self.singleActions) {
        numberOfRows = [self.allSingleActionsForLocation count];
    } else {
        numberOfRows = [self.allGroupActionsForLocation count];
    }
    return numberOfRows;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return !self.singleActions;
}

- (void)configureCell:(UITableViewCell *)cell atIdexPath:(NSIndexPath *)indexPath
{
    NZAction *action;
    if (self.singleActions) {
        action = [self.allSingleActionsForLocation objectAtIndex:indexPath.row];
    } else {
        action = [self.allGroupActionsForLocation objectAtIndex:indexPath.row];
    }
    cell.textLabel.text = action.name;
}

#pragma mark - UI Table View Delegate

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    self.configGroupActionTvc.groupAction = [self.allGroupActionsForLocation objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.configGroupActionTvc.groupNameLabel.text = cell.textLabel.text;
    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:self.configGroupActionTvc];
    [popover presentPopoverFromRect:self.actionsTableView.layer.frame inView:self.actionsTableView permittedArrowDirections:0 animated:YES];
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Get the managedObjectContext from the AppDelegate (for use in CoreData Applications)
   // AppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
   // NSManagedObjectContext *context = appdelegate.managedObjectContext;
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        NZActionComposite *action = [self.allGroupActionsForLocation objectAtIndex:indexPath.row];
        NSMutableArray *tmpArray = [NSMutableArray arrayWithArray:self.allGroupActionsForLocation];
        [tmpArray removeObject:action];
        [action destroy];
        self.allGroupActionsForLocation = (NSArray *)tmpArray;
      //  [[NZCoreDataManager sharedManager] save];
        // Animate the deletion
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        

        // Additional code to configure the Edit Button, if any
        if ([self.allGroupActionsForLocation count] == 0) {
            self.editButton.enabled = NO;
            self.editButton.titleLabel.text = @"Edit";
        }
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    NZAction *action = [self.allSingleActions objectAtIndex:indexPath.row];
    [self.selectedGroupAction removeChildActionsObject:action];
    
    [[NZCoreDataManager sharedManager] save];
     */
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    NZAction *action = [self.allSingleActions objectAtIndex:indexPath.row];
    if ([[self.selectedGroupAction.childActions allObjects] containsObject:action]) {
        //cell.selected = true;
        cell.highlighted = true;
    }
     */
}

#pragma mark - IB Actions
- (IBAction)singleGroupSegmentValueChanged:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        self.singleActions = true;
    } else {
        self.singleActions = false;
    }
}

- (IBAction)editButtonTapped:(UIButton *)sender {
    if ([self.actionsTableView isEditing]) {
        [self.actionsTableView setEditing:NO animated:YES];
        [self.editButton setImage:[UIImage imageNamed:@"delete_circle"] forState:UIControlStateNormal];
    } else {
        [self.actionsTableView setEditing:YES animated:YES];
        [self.editButton setImage:[UIImage imageNamed:@"check_circle"] forState:UIControlStateNormal];
       // [self.editButton setTitle:@"Done" forState:UIControlStateNormal];
    }
}

- (IBAction)addButtonTapped:(UIButton *)sender {
    if (!self.addActionGroupAlertController) {
        
        self.addActionGroupAlertController = [UIAlertController alertControllerWithTitle:@"Add new Group" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction *doneAction = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self addActionComposite];
        }];
        [self.addActionGroupAlertController addAction:doneAction];
        [self.addActionGroupAlertController addAction:cancelAction];
        [self.addActionGroupAlertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"Enter group name here";
        }];
    }
    [self presentViewController:self.addActionGroupAlertController animated:YES completion:nil];
}

#pragma mark - setters & getters
- (void)setSelectedLocation:(NZLocation *)selectedLocation
{
    _selectedLocation = selectedLocation;
    self.allSingleActionsForLocation = [NZSingleAction findAllSortedByNameActionsForLocation:selectedLocation.name];
    self.allGroupActionsForLocation = [NZActionComposite findAllSortedByNameActionsForLocation:selectedLocation.name];
    [self.actionsTableView reloadData];
}

- (void)setSingleActions:(BOOL)singleActions
{
    _singleActions = singleActions;
    self.editButton.hidden = singleActions;
    self.addButton.hidden = singleActions;
    [self.actionsTableView reloadData];
}

#pragma mark - helper methods
- (void)addActionComposite
{
    
    UITextField *textField = [self.addActionGroupAlertController.textFields objectAtIndex:0];
    
    if ([textField.text isEqualToString:@""]) {
        return;
    }
    if ([NZAction existsWithName:textField.text]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"a group with the given name already exists" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    NZActionComposite *newGroup = [NZActionComposite create];
    newGroup.name = textField.text;
    newGroup.location = self.selectedLocation;
    
    NZCoreDataManager *manager = [NZCoreDataManager sharedManager];
    [manager save];
    
    self.allGroupActionsForLocation = [NZActionComposite findAllSortedByNameActionsForLocation:self.selectedLocation.name];
    [self.actionsTableView reloadData];

}

@end
