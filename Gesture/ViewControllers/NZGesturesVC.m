//
//  NZGesturesVC.m
//  Gesture
//
//  Created by Natalia Zarawska on 7/15/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZGesturesVC.h"
#import "NZGesturesVC.h"
#import "NZGesture+CoreData.h"
#import "NZClassLabel+CoreData.h"
#import "NZCoreDataManager.h"
#import "NZGestureConfigurationVC.h"
#import "NZPipelineController.h"
#import "NZGestureSetHandler.h"


@interface NZGesturesVC ()

#warning to be created

#pragma mark - Core Data related properties
@property (nonatomic, strong) NZPopupViewController *popupVc;
@property (nonatomic, strong) NSDate *currentDate;
@property (nonatomic, strong) NZGestureConfigurationVC *gestureConfigurationVc;

@property (nonatomic, strong) UIBarButtonItem *addButton;
@property (nonatomic, strong) UIBarButtonItem *editButton;
@property (nonatomic, strong) UIBarButtonItem *doneButton;

@end

@implementation NZGesturesVC

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
    
    self.addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewItem:)];
    self.editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(startEditing:)];
    self.doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneEditing:)];
    self.navigationItem.rightBarButtonItems = @[self.editButton, self.addButton];
    
    // setup popup VC
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *popUpVc = [storyboard instantiateViewControllerWithIdentifier:@"PopUpVC"];
    if ([popUpVc isKindOfClass:[NZPopupViewController class]]) {
        self.popupVc = (NZPopupViewController *)popUpVc;
        self.popupVc.delegate = self;
    }
    
    // setup the next vc in the navigation hierarchy
    UIViewController *gestureConfigurationVc = [storyboard instantiateViewControllerWithIdentifier:@"GestureConfigurationVC"];
    if ([gestureConfigurationVc isKindOfClass:[NZGestureConfigurationVC class]]) {
        self.gestureConfigurationVc = (NZGestureConfigurationVC *)gestureConfigurationVc;
    }
    
    self.gestureSet = [NZGestureSetHandler sharedManager].selectedGestureSet;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.gestureSet.gestures count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GestureCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GestureCell"];
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
        
        NZGesture *gesture = [[self.gestureSet.gestures allObjects] objectAtIndex:indexPath.row];
        [[NZPipelineController sharedManager] removeClassLabel:gesture.label];
        [gesture destroy];
        
      //  [context deleteObject:[[self.gestureSet.gestures allObjects] objectAtIndex:indexPath.row]];
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        
        [self.tableView reloadData];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        NSLog(@"insert a cell");
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NZGesture *selectedGesture = [[self.gestureSet.gestures allObjects] objectAtIndex:indexPath.row];
    NZClassLabel *label = selectedGesture.label;
    self.gestureConfigurationVc.gesture = selectedGesture;
    self.gestureConfigurationVc.navigationItem.title = label.name;
  //  self.gestureConfigurationVc.navigationController.title = label.name;
    [[self navigationController] pushViewController:self.gestureConfigurationVc animated:YES];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
#warning TODO configure the cell properly
    NZGesture *gesture = [[self.gestureSet.gestures allObjects] objectAtIndex:indexPath.row];
    NSDate *date = [gesture valueForKey:@"timeStampCreated"];
    cell.textLabel.text = gesture.label.name;
}

#pragma mark - methods handling editing of the table view cells
- (void)insertNewItem:(id)sender {
    [self presentViewController:self.popupVc animated:YES completion:nil];
    self.currentDate = [NSDate date];
    self.popupVc.timestampText.text = [self.currentDate description];
    self.popupVc.nameText.text = self.popupVc.timestampText.text;
}

- (void)startEditing:(id)sender
{
    self.navigationItem.rightBarButtonItems = @[self.doneButton, self.addButton];
    [self.tableView setEditing:YES animated:YES];
    self.addButton.enabled = false;
}

- (void)doneEditing:(id)sender
{
    self.navigationItem.rightBarButtonItems = @[self.editButton, self.addButton];
    [self.tableView setEditing:NO animated:YES];
    self.addButton.enabled = true;
}


#pragma mark - Pop Up VC Delegate methods
- (void)didFinishFillingFormWithData:(NSDictionary *)form
{
    [self dismissViewControllerAnimated:YES completion:nil];
    NSManagedObjectContext *context = [[NZCoreDataManager sharedManager] managedObjectContext];
    NZGesture *newGesture = [NSEntityDescription insertNewObjectForEntityForName:ENTITY_NAME_GESTURE inManagedObjectContext:context];

    
    [newGesture setValue:self.currentDate forKey:@"timeStampCreated"];
    [newGesture setValue:self.currentDate forKey:@"timeStampUpdated"];
    [self.gestureSet addGesturesObject:newGesture];
    [newGesture setValue:self.gestureSet forKey:@"gestureSet"];
    
    // create a new class label with the correct index
   // NZClassLabel *newClassLabel = [NSEntityDescription insertNewObjectForEntityForName:ENTITY_NAME_CLASS_LABEL inManagedObjectContext:context];
    NZClassLabel *lastClassObject = [NZClassLabel findLates];
    NSNumber *index = [NSNumber numberWithInt:1];
    if (lastClassObject) {
        index = [NSNumber numberWithInt:[lastClassObject.index intValue]+1 ];
    }
    NZClassLabel *newClassLabel = [NZClassLabel create];
    [newClassLabel setValue:[form objectForKey:@"name"]forKey:@"name"];
    [newClassLabel setValue:index forKey:@"index"];
    [newClassLabel setValue:newGesture forKey:@"gesture"];
    [newGesture setValue:newClassLabel forKey:@"label"];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    [self.tableView reloadData];
    
    NSLog(@"done inserting new item");
    
}


@end
