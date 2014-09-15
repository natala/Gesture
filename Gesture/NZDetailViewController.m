//
//  NZDetailViewController.m
//  Gesture
//
//  Created by Natalia Zarawska on 6/26/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZDetailViewController.h"
#import "NZSensorData.h"
#import "NZSensorDataSet.h"
#import "Views/RecordingSensorDataTableView/NZSensorDataSetTableViewCell.h"
#import "Model/CoreData/NZCoreDataManager.h"
#import "NZLinearAcceleration.h"
#import "NZYawPitchRoll+CoreData.h"
#import "NZGraphView.h"

@interface NZDetailViewController ()

@property (strong, nonatomic) UIPopoverController *masterPopoverController;

@end

@implementation NZDetailViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // setup tge UI
    self.startRecordingButton.enabled = YES;
    self.stopRecordingButton.enabled = NO;
    self.recordingStatusLabel.text = @" - - - ";
    
    //setup the chart views
    // Linear Acc
    KHLinearAccelerationLineChartView *linearAccChartView = [[KHLinearAccelerationLineChartView alloc] initWithFrame:self.linearAccelerationLineChartView.frame];
    linearAccChartView.tag = 1000; // I don't thing I need it, but is fancy :D
    [self.view addSubview:linearAccChartView];
    
    KHYawPitchRollLineChartView *yawPitchRollChartView = [[KHYawPitchRollLineChartView alloc] initWithFrame:self.yawPitchRollLineChartView.frame];
    yawPitchRollChartView.tag = 1001;
    [self.view addSubview:yawPitchRollChartView];
    
    self.buttonStateLabel.text = @"";
    
    //NZGraphView *linearAccGraphView = [[NZGraphView alloc] initWithFrame:self.linearAccelerationLineChartView.frame];
    //linearAccGraphView.tag = 1000;
    //NZGraphView *yawPitchRollGraphView = [[NZGraphView alloc] initWithFrame:self.yawPitchRollLineChartView.frame];
    //yawPitchRollGraphView.tag = 1001;
    
    /* linearAccGraphView.normalizeFactor = 1.0;
     linearAccGraphView.maxAxisY = 20000.0;
     linearAccGraphView.minAxisY = -20000.0;
     
     yawPitchRollGraphView.normalizeFactor = 1.0;
     yawPitchRollGraphView.minAxisY = -180;
     yawPitchRollGraphView.maxAxisY = 180;*/
    
    //self.linearAccelerationLineChartView = linearAccGraphView;
    //[self.view addSubview:linearAccGraphView];
    //[self.view addSubview:yawPitchRollGraphView];
    
    //Setup the table view controller editing
    // self.navigationItem.leftBarButtonItem = self.editButtonItem;
   // UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
   // self.navigationItem.rightBarButtonItem = addButton;
    // enable deleting the sensor data sets
    //[self.sensorDataTableView setEditing:YES animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

#pragma mark - NZSensorDataRecordingManagerObserver
- (void)didStartRecordingSensorData:(NZSensorDataSet *)sensorDataSet
{
    [self updateLinearAccelerationLineChartViewWithSession:sensorDataSet onlyShowLatest50SensorData:NO];
    self.recordingStatusLabel.text = @"recording";
    self.startRecordingButton.enabled = NO;
    self.stopRecordingButton.enabled = YES;
    
}

- (void)didReceiveSensorData:(NZSensorData *)sensorData forSensorDataSet:(NZSensorDataSet *)sensorDataSet
{
    NSString *acc = [NSString stringWithFormat:@"acc: %@, %@, %@", [sensorData.linearAcceleration.x stringValue], [sensorData.linearAcceleration.y stringValue], [sensorData.linearAcceleration.z stringValue]];
    NSString *yawPitchRoll = [NSString stringWithFormat:@"ypr: %@, %@, %@", [sensorData.yawPitchRoll.yaw stringValue], [sensorData.yawPitchRoll.pitch stringValue], [sensorData.yawPitchRoll.roll stringValue]];
    
    self.accelerationLabel.text = acc;
    self.orientationLabel.text = yawPitchRoll;
    
    [self updateLinearAccelerationLineChartViewWithSession:sensorDataSet onlyShowLatest50SensorData:YES];
}

- (void)didStopRecordingSensorDataSet:(NZSensorDataSet *)sensorDataSet
{
    NSLog(@"Stoped receiving sensor data");
    self.recordingStatusLabel.text = @"stopped recording";
    self.startRecordingButton.enabled = YES;
    self.stopRecordingButton.enabled = NO;
}

- (void)buttonStateDidChangeFrom:(ButtonState)previousState to:(ButtonState)currentButtonState
{
    switch (currentButtonState) {
        case BUTTON_NOT_PRESSED:
            self.buttonStateLabel.text = @"button not pressed";
            break;
        case BUTTON_SHORT_PRESS:
            self.buttonStateLabel.text = @"button short press";
            break;
        case BUTTON_LONG_PRESS:
            self.buttonStateLabel.text = @"button long press";
            break;
        case BUTTON_DOUBLE_PRESS:
            self.buttonStateLabel.text = @"button double press";
        default:
            break;
    }
}

#pragma mark - IBAction

- (IBAction)startRecordingButtonPressed:(id)sender
{
    [[NZSensorDataRecordingManager sharedManager] addRecordingObserver:self];
    [[NZSensorDataRecordingManager sharedManager] prepareForRecordingSensorDataSet];
  //  [[NZSensorDataRecordingManager sharedManager] startRecordingNewSensorDataSet];
    BOOL startedNewRecording = [[NZSensorDataRecordingManager sharedManager] startRecordingNewSensorDataSet];
    
    // if (startedNewRecording) {
    //         }
}

- (IBAction)stopRecordingButtonPressed:(id)sender
{
    [[NZSensorDataRecordingManager sharedManager] stopRecordingCurrentSensorDataSet];
}
/*
#pragma mark - TableViw

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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[NZSensorDataSetTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"Deleting a cell");
        NSManagedObjectContext *context = [[NZCoreDataManager sharedManager] managedObjectContext];
        //   NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    NSLog(@"selected cell, to be implemented!");
    // self.detailViewController.detailItem = object;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [[object valueForKey:@"timeStampCreated"] description];
}
*/

/*
#pragma mark - editing the view

- (void)insertNewObject:(id)sender {
    
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    // If appropriate, configure the new managed object.
    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
    [newManagedObject setValue:[NSDate date] forKey:@"timeStampCreated"];
    
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
 */

#pragma mark - Fetched results controller
/*
- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    //NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"NZSensorDataSet"];
    // Edit the entity name as appropriate.
    NSManagedObjectContext *context = [[NZCoreDataManager sharedManager] managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"NZSensorDataSet" inManagedObjectContext:context];
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
    [self.sensorDataTableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.sensorDataTableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.sensorDataTableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.sensorDataTableView;
    
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
    [self.sensorDataTableView endUpdates];
}
 */

#pragma mark - Helper

- (void)updateLinearAccelerationLineChartViewWithSession:(NZSensorDataSet *)set onlyShowLatest50SensorData:(BOOL)onlyShowLatest50SensorData
{
    NSMutableArray *sensorDataArray = [NSMutableArray arrayWithArray:[set.sensorData allObjects]];
    NZSensorData *sensorData = sensorDataArray.lastObject;
    
    if (!sensorData) {
        return;
    }
    
    // [self.linearAccelerationLineChartView addX:[sensorData.linearAcceleration.x floatValue] y:[sensorData.linearAcceleration.y floatValue] z:[sensorData.linearAcceleration.z floatValue]];
    //[self.yawPitchRollLineChartView addX:[sensorData.yawPitchRoll.yaw floatValue] y:[sensorData.yawPitchRoll.pitch floatValue] z:[sensorData.yawPitchRoll.roll floatValue]];
    
    self.linearAccelerationLineChartView.sensorData = sensorDataArray;
    //self.yawPitchRollLineChartView.sensorData = sensorDataArray;
    
}

@end;
