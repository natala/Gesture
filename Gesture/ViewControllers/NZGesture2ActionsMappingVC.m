//
//  NZGesture2ActionsMappingVC.m
//  Gesture
//
//  Created by Natalia Zarawska on 8/26/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZGesture2ActionsMappingVC.h"
#import "NZGesture+CoreData.h"
#import "NZClassLabel+CoreData.h"
#import "NZSingleAction+CoreData.h"
#import "NZActionComposite+CoreData.h"
#import "NZCoreDataManager.h"

@interface NZGesture2ActionsMappingVC ()

@property (nonatomic, strong) UIPopoverController *singleActionPopoverController;
@property (nonatomic, strong) UIPopoverController *compositeActionPopoverController;

@property (nonatomic, strong) UIPickerView *singleActionPicker;
@property (nonatomic, strong) UIPickerView *compositeActionPicker;

/**
 * the index path of the cell to which the tapped button belongs to
 */
@property (nonatomic, strong) NSIndexPath  *selectedIndexPath;

@property (nonatomic, strong) NSArray *singleActions;
@property (nonatomic, strong) NSArray *compositeActions;
@property (nonatomic, strong) NSArray *gestures;

@end

@implementation NZGesture2ActionsMappingVC

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.singleActions = [NZSingleAction findAllSortedByName];
    self.compositeActions = [NZActionComposite findAllSortedByName];
    self.gestures = [NZGesture findAllSortetByLabel];
    
    UIViewController *popoverContent = [[UIViewController alloc] init];
    UIView *popoverView = [[UIView alloc] init];
    //popoverView.backgroundColor = [UIColor whiteColor];
    
    self.singleActionPicker = [[UIPickerView alloc] init];
    self.singleActionPicker.frame = CGRectMake(0, 0, 320, 216);
    self.singleActionPicker.delegate = self;
    self.singleActionPicker.dataSource = self;
    [popoverView addSubview:self.singleActionPicker];
    popoverContent.view = popoverView;
    self.singleActionPopoverController = [[UIPopoverController alloc] initWithContentViewController:popoverContent];
    self.singleActionPopoverController.delegate = self;
    [self.singleActionPopoverController setPopoverContentSize:CGSizeMake(320, 216) animated:YES];
    
    popoverContent = [[UIViewController alloc] init];
    popoverView = [[UIView alloc] init];
    //popoverView.backgroundColor = [UIColor whiteColor];
    
    self.compositeActionPicker = [[UIPickerView alloc] init];
    self.compositeActionPicker.frame = CGRectMake(0, 0, 320, 216);
    self.compositeActionPicker.delegate = self;
    self.compositeActionPicker.dataSource = self;
    [popoverView addSubview:self.compositeActionPicker];
    popoverContent.view = popoverView;
    self.compositeActionPopoverController = [[UIPopoverController alloc] initWithContentViewController:popoverContent];
    self.compositeActionPopoverController.delegate = self;
    [self.compositeActionPopoverController setPopoverContentSize:CGSizeMake(320, 216) animated:YES];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return [self.gestures count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Gesture2actionsCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Gesture2actionsCell"];
    }
    //[cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    NZGesture *gesture = [self.gestures objectAtIndex:[indexPath section]];
    //UIButton *button;
    switch ([indexPath row]) {
        case 0:
            cell.textLabel.text = @"action";
            if (gesture.singleAction) {
                cell.detailTextLabel.text = gesture.singleAction.name;
            } else {
                cell.detailTextLabel.text = @"none";
            }
            break;
        case 1:
            cell.textLabel.text = @"group";
            if (gesture.actionComposite) {
                cell.detailTextLabel.text = gesture.actionComposite.name;
            } else {
                cell.detailTextLabel.text = @"none";
            }
            break;
        default:
            break;
    }
    UIButton *button;
    button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.frame = CGRectMake(cell.frame.size.width - 40, 0, 40, cell.frame.size.height);
    [button addTarget:self action:@selector(cellButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    NSInteger tag = [indexPath section]*10 + [indexPath row];
    button.tag = tag;
    [cell.contentView addSubview:button];
    return cell;
}

- (void)cellButtonPressed:(id)sender
{
    if ([sender isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)sender;
        NSInteger row;
        NSLog(@"%d", button.tag);
        if (button.tag%10 == 0) {
            row = 0;
            [self.singleActionPopoverController presentPopoverFromRect:button.bounds inView:button permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        } else {
            row =1;
            [self.compositeActionPopoverController presentPopoverFromRect:button.bounds inView:button permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
        self.selectedIndexPath = [NSIndexPath indexPathForRow:row inSection:button.tag/10];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NZGesture *gesture = [self.gestures objectAtIndex:section];
    return gesture.label.name;
}

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"tapped!!");
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - picker view data source methods

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ([pickerView isEqual:self.singleActionPicker]) {
        return [self.singleActions count]+1;
    }
    if ([pickerView isEqual:self.compositeActionPicker]) {
        return [self.compositeActions count]+1;
    }
    return 0;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


#pragma mark - picker view delegate methods

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if ([pickerView isEqual:self.singleActionPicker]) {
        if (row == [self.singleActions count]) {
            return @"none";
        }
        NZSingleAction *action = [self.singleActions objectAtIndex:row];
        return action.name;
    }
    if ([pickerView isEqual:self.compositeActionPicker]) {
        if (row == [self.compositeActions count]) {
            return @"none";
        }
        NZActionComposite *action = [self.compositeActions objectAtIndex:row];
        return action.name;
    }
    return nil;
}

#pragma mark - popover delegate methods

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    NZGesture *gesture = [self.gestures objectAtIndex:self.selectedIndexPath.section];
    NZActionComposite *composit = gesture.actionComposite;
    NZSingleAction *single = gesture.singleAction;
   // UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.selectedIndexPath];
  if ([popoverController isEqual:self.singleActionPopoverController]) {
        NSUInteger selectedAction = [self.singleActionPicker selectedRowInComponent:0];
        if (selectedAction == [self.singleActions count]) {
            [gesture.singleAction removeGestureObject:gesture];
          //  gesture.singleAction = nil;
          //  cell.detailTextLabel.text = @"no action";
        } else {
            NZSingleAction *action = [self.singleActions objectAtIndex:selectedAction];
            gesture.singleAction = action;
            [action addGestureObject:gesture];
          //  cell.detailTextLabel.text = gesture.singleAction.name;
        }
      gesture.actionComposite = composit;
    } else if ([popoverController isEqual:self.compositeActionPopoverController]) {
        NSUInteger selectedAction = [self.compositeActionPicker selectedRowInComponent:0];
        if (selectedAction == [self.compositeActions count]) {
            [gesture.actionComposite removeGestureObject:gesture];
           // gesture.actionComposite = nil;
          //  cell.detailTextLabel.text = @"no action";
        } else {
            gesture.actionComposite = [self.compositeActions objectAtIndex:selectedAction];
            [[self.compositeActions objectAtIndex:selectedAction] addGestureObject:gesture];
          //  cell.detailTextLabel.text = gesture.actionComposite.name;
        }
        gesture.singleAction = single;
    }
    
    [self.tableView reloadData];
    
    /*NZClassLabel *label = [NZClassLabel create];
    label.name = @"$$$$$$$$$$$$$";
    [NZGesture create].label = label;
     */
    
    NSManagedObjectContext *context = [[NZCoreDataManager sharedManager] managedObjectContext];
    NZCoreDataManager *manager = [NZCoreDataManager sharedManager];
    [manager save];
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    self.selectedIndexPath = nil;
}

#pragma mark - getters and setters

@end
