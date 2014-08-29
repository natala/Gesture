//
//  NZActionsVC.m
//  Gesture
//
//  Created by Natalia Zarawska on 8/14/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZActionsVC.h"
#import "NZCoreDataManager.h"
#import "NZSingleAction+CoreData.h"
#import "NZActionComposite+CoreData.h"
//#import "NZHttpRequest+CoreData.h"

@interface NZActionsVC ()

@property (weak, nonatomic) IBOutlet UITableView *actionsTableView;
@property (weak, nonatomic) IBOutlet UITableView *groupsTableView;

@property (retain, nonatomic) NSArray *singleActions;


// @property (nonatomic, strong) NSFetchedResultsController *actionsFetchedResultsController;
// /*@property (nonatomic, strong) NSFetchedResultsController *actionCompositsFetchedResultsController;

// @property (nonatomic, strong) UIBarButtonItem *addButton;
// @property (nonatomic, strong) UIBarButtonItem *editButton;
// @property (nonatomic, strong) UIBarButtonItem *doneButton;

@end

@implementation NZActionsVC

/*- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}*/

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.singleActions = [NZSingleAction findAllSortedByName];
  /*  self.addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewItem:)];
    self.editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(startEditing:)];
    self.doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneEditing:)];
    self.navigationItem.rightBarButtonItems = @[self.editButton, self.addButton];
    
   */
    //create some dumm actions for debugging
   // NZActionComposite *actionComposite = [NZActionComposite create];
   // actionComposite.name = @"a composite";
    
   // NZHttpRequest *httpRequest = [NZHttpRequest create];
   // httpRequest.name = @"a http request";
    
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
    // Return the number of rows in the section.
    /*id <NSFetchedResultsSectionInfo> sectionInfo;
     if ([tableView isEqual:self.actionsTableView]) {
     sectionInfo = [self.actionsFetchedResultsController sections][section];
     } else if ([tableView isEqual:self.groupsTableView]) {
     sectionInfo = [self.actionCompositsFetchedResultsController sections][section];
     }
     return [sectionInfo numberOfObjects];
     */
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of sections.
    if ([tableView isEqual:self.actionsTableView]) {
        //return [[self.actionsFetchedResultsController sections] count];
        return [self.singleActions count];
    } else if ([tableView isEqual:self.groupsTableView])
        //return [[self.actionCompositsFetchedResultsController sections] count];
        return [[NZActionComposite findAll] count];
    else return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if ([tableView isEqual:self.actionsTableView]) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"ActionCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ActionCell"];
        }
    } else if ([tableView isEqual:self.groupsTableView]) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"ActionGroupCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ActionGroupCell"];
        }
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    [self configureCell:cell atIndexPath:indexPath forTable:tableView];
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*if ([tableView isEqual:self.actionsTableView]) {
        <#statements#>
    } else if ([tableView isEqual:self.groupsTableView]) {
    
    }*/
    
    #warning implement
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSLog(@"Deleting cell");
        if ([tableView isEqual:self.actionsTableView]) {
           //[[self.actionsFetchedResultsController objectAtIndexPath:indexPath] destroy];
           // [self.actionsTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [[self.singleActions objectAtIndex:[indexPath row]] destroy];
         } else if ([tableView isEqual:self.groupsTableView]) {
            [self.groupsTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
           //[[self.actionCompositsFetchedResultsController objectAtIndexPath:indexPath] destroy];
         }
  //      [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        NSManagedObjectContext *context = [[NZCoreDataManager sharedManager] managedObjectContext];
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        NSLog(@"isnerting a cell");
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

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

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath forTable:(UITableView *)tableView {
    NSManagedObject *object;
    if ([tableView isEqual:self.actionsTableView]) {
        object = [self.singleActions objectAtIndex:[indexPath row]]; //[self.actionsFetchedResultsController objectAtIndexPath:indexPath];
    } else if ([tableView isEqual:self.groupsTableView]) {
        object = [[NZActionComposite findAllSortedByName] objectAtIndex:[indexPath row]]; //[self.actionCompositsFetchedResultsController objectAtIndexPath:indexPath];
    }
    cell.textLabel.text = [object valueForKey:@"name"];
}

#pragma mark - methods handling editing of the rable view cells
- (void)insertNewItem:(id)sender {
    UIButton *senderButton = (UIButton *)sender;
    // [self presentViewController:self.popupVc animated:YES completion:nil];
    // self.currentDate = [NSDate date];
    // self.popupVc.timestampText.text = [self.currentDate description];
    // self.popupVc.nameText.text = self.popupVc.timestampText.text;
    // self.popupVc.view.frame = self.view.frame;
    
    NZActionComposite *newComposite = [NZActionComposite create];
    newComposite.name = @"added new composite";
    NSLog(@"insert new item!!");
}
/*
- (void)startEditing:(id)sender
{
    self.navigationItem.rightBarButtonItems = @[self.doneButton, self.addButton];
    [self.actionsTableView setEditing:YES animated:YES];
   // [self.groupsTableView setEditing:YES animated:YES];
    self.addButton.enabled = false;
}

- (void)doneEditing:(id)sender
{
    self.navigationItem.rightBarButtonItems = @[self.editButton, self.addButton];
    [self.actionsTableView setEditing:NO animated:YES];
    [self.groupsTableView setEditing:NO animated:YES];
    self.addButton.enabled = true;
}
*/

/*
#pragma mark - Fetched results controller
- (NSFetchedResultsController *)actionsFetchedResultsController
{
    if ( _actionsFetchedResultsController != nil) {
        return _actionsFetchedResultsController;
    }
    
    //NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:ENTITY_NAME_SINGLE_ACTION];
    // Edit the entity name as appropriate.
    NSManagedObjectContext *context = [[NZCoreDataManager sharedManager] managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:ENTITY_NAME_SINGLE_ACTION inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    self.actionsFetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.actionsFetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _actionsFetchedResultsController;
}

- (NSFetchedResultsController *)actionCompositsFetchedResultsController
{
    if ( _actionCompositsFetchedResultsController != nil) {
        return _actionCompositsFetchedResultsController;
    }
    
    //NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:ENTITY_NAME_ACTION_COMPOSITE];
    // Edit the entity name as appropriate.
    NSManagedObjectContext *context = [[NZCoreDataManager sharedManager] managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:ENTITY_NAME_ACTION_COMPOSITE inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    self.actionCompositsFetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.actionsFetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _actionCompositsFetchedResultsController;

}
*/

@end
