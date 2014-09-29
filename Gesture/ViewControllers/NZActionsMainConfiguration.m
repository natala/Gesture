//
//  NZActionsMainConfiguration.m
//  Gesture
//
//  Created by Natalia Zarawska on 9/26/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZActionsMainConfiguration.h"

#import "NZAction+CoreData.h"
#import "NZSingleAction+CoreData.h"
#import "NZCoreDataManager.h"
#import "NZActionComposite+CoreData.h"

@interface NZActionsMainConfiguration ()

#pragma  mark - UI Elements
@property (weak, nonatomic) IBOutlet UIButton *gesturesButton;
@property (weak, nonatomic) IBOutlet UITableView *singleActionsTableView;
@property (weak, nonatomic) IBOutlet UIPickerView *groupActionsPickerView;

#pragma mark - Action Related
@property (retain, nonatomic) NZActionComposite *selectedGroupAction;
@property (retain, nonatomic) NSArray *allSingleActions;
@property (retain, nonatomic) NSArray *allGroupActions;


@end

@implementation NZActionsMainConfiguration

- (void)viewDidLoad {
    [super viewDidLoad];
    self.allSingleActions = [NZSingleAction findAllSortedByName];
    self.allGroupActions = [NZActionComposite findAllSortedByName];
    if ([self.allGroupActions count] > 0) {
        self.selectedGroupAction = [self.allGroupActions objectAtIndex:0];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

# pragma mark - IB Actions

- (IBAction)gesturesButtonTapped:(UIButton *)sender {
}

- (IBAction)plusButtonTapped:(UIButton *)sender {
}

- (IBAction)minusButtonTapped:(UIButton *)sender {
}

#pragma mark - UI Picker View Data Source
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.allGroupActions count];
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
    NZAction *action = [self.allGroupActions objectAtIndex:row];
    return action.name;
}

/*
 pickerView:attributedTitleForRow:forComponent:
 pickerView:viewForRow:forComponent:reusingView:
 */

// Responding to Row Selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedGroupAction = [self.allGroupActions objectAtIndex:row];
}

#pragma mark - UI Table View Data Source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingleGestureCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SingleGestureCell"];
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
    return [self.allSingleActions count];
}

- (void)configureCell:(UITableViewCell *)cell atIdexPath:(NSIndexPath *)indexPath
{
    NZAction *action = [self.allSingleActions objectAtIndex:indexPath.row];
    cell.textLabel.text = action.name;
    if ([[self.selectedGroupAction.childActions allObjects] containsObject:action]) {
        //cell.selected = true;
        cell.highlighted = true;
    }
}

#pragma mark - UI Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NZAction *action = [self.allSingleActions objectAtIndex:indexPath.row];
    [self.selectedGroupAction addChildActionsObject:action];
    [[NZCoreDataManager sharedManager] save];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NZAction *action = [self.allSingleActions objectAtIndex:indexPath.row];
    [self.selectedGroupAction removeChildActionsObject:action];
    
    [[NZCoreDataManager sharedManager] save];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NZAction *action = [self.allSingleActions objectAtIndex:indexPath.row];
    if ([[self.selectedGroupAction.childActions allObjects] containsObject:action]) {
        //cell.selected = true;
        cell.highlighted = true;
    }
}

#pragma mark - getters & setters
- (void)setSelectedGroupAction:(NZActionComposite *)selectedGroupAction{
    _selectedGroupAction = selectedGroupAction;
    [self updateSingleActions];
    
}

#pragma mark - helper methods

- (void)updateSingleActions
{
    [self.singleActionsTableView reloadData];
    /*if (self.selectedGroupAction) {
        for (NZAction *action in self.selectedGroupAction.childActions) {
            int index = [self.allSingleActions indexOfObjectIdenticalTo:action];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
            UITableViewCell *cell = [self.singleActionsTableView cellForRowAtIndexPath:indexPath];
            if (!cell.isHidden) {
                [self.singleActionsTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
            }
        }
    }*/
}

@end
