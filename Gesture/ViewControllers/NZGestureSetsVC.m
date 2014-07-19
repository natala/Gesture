//
//  NZGestureSetsVC.m
//  Gesture
//
//  Created by Natalia Zarawska on 7/15/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZGestureSetsVC.h"
#import "NZGesturesVC.h"
#import "NZGestureSet+CoreData.h"
#import "NZCoreDataManager.h"


@interface NZGestureSetsVC ()

@property (nonatomic, strong) NZGesturesVC *gestureSetVC;

#pragma mark - Core Data related properties
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NZPopupViewController *popupVc;
@property (nonatomic, strong) NSDate *currentDate;

@end

@implementation NZGestureSetsVC

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
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewItem:)];
    self.navigationItem.rightBarButtonItem = addButton;
    [self.tableView setEditing:YES animated:YES];
    
    // setup popup VC
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *popUpVc = [storyboard instantiateViewControllerWithIdentifier:@"PopUpVC"];
    if ([popUpVc isKindOfClass:[NZPopupViewController class]]) {
        self.popupVc = (NZPopupViewController *)popUpVc;
        self.popupVc.delegate = self;
    }
    self.tableView.allowsSelectionDuringEditing = YES;

    UIViewController *gesturesVC = [storyboard instantiateViewControllerWithIdentifier:@"GestureSetVC"];
    if ([gesturesVC isKindOfClass:[NZGesturesVC class]]) {
        self.gestureSetVC = (NZGesturesVC *)gesturesVC;
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GestureSetCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GestureSetCell"];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"Deleting a cell");
        NSManagedObjectContext *context = [[NZCoreDataManager sharedManager] managedObjectContext];
        //NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        //[context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        [[self.fetchedResultsController objectAtIndexPath:indexPath] destroy];
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        NSLog(@"insert a cell");
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.gestureSetVC.gestureSet = [self.fetchedResultsController objectAtIndexPath:indexPath];
    self.gestureSetVC.navigationItem.title = self.gestureSetVC.gestureSet.name;
    [self.gestureSetVC.tableView reloadData];
    [[self navigationController] pushViewController:self.gestureSetVC animated:YES];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
#warning TODO configure the cell properly
    NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [object valueForKey:@"name"];
}

#pragma mark - methods handling editing of the rable view cells 
- (void)insertNewItem:(id)sender {
    [self presentViewController:self.popupVc animated:YES completion:nil];
    self.currentDate = [NSDate date];
    self.popupVc.timestampText.text = [self.currentDate description];
    self.popupVc.nameText.text = self.popupVc.timestampText.text;
    //self.popupVc.view.frame = self.view.frame;
}

#pragma mark - Fetched results controller
- (NSFetchedResultsController *)fetchedResultsController
{
    if ( _fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    //NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:ENTITY_NAME_GESTURE_SET];
    // Edit the entity name as appropriate.
    NSManagedObjectContext *context = [[NZCoreDataManager sharedManager] managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:ENTITY_NAME_GESTURE_SET inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timeStampCreated" ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}



#pragma mark Pop Up VC Delegate methods
- (void)didFinishFillingFormWithData:(NSDictionary *)form
{
    [self dismissViewControllerAnimated:YES completion:nil];
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    // If appropriate, configure the new managed object.
    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
    [newManagedObject setValue:self.currentDate forKey:@"timeStampCreated"];
    [newManagedObject setValue:self.currentDate forKey:@"timeStampUpdated"];
    [newManagedObject setValue:[form valueForKey:@"name"] forKey:@"name"];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    NSLog(@"done inserting new item");
    
}


@end
