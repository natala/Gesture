//
//  NZGesturesVC.m
//  Gesture
//
//  Created by Natalia Zarawska on 7/15/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZGesturesVC.h"
#import "NZGesturesVC.h"
#import "NZGesture.h"
#import "NZClassLabel+CoreData.h"
#import "NZCoreDataManager.h"


@interface NZGesturesVC ()

#warning to be created
@property (nonatomic, strong) UIViewController *recordGestureVc;

#pragma mark - Core Data related properties
@property (nonatomic, strong) NZPopupViewController *popupVc;
@property (nonatomic, strong) NSDate *currentDate;

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
    
    // setup VC for recording the gesture
    UIViewController *gesturesVC = [storyboard instantiateViewControllerWithIdentifier:@"SingleGestureVC"];
    if ([gesturesVC isKindOfClass:[NZGesturesVC class]]) {
        self.recordGestureVc = (UIViewController *)gesturesVC;
    }
    
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
        [context deleteObject:[[self.gestureSet.gestures allObjects] objectAtIndex:indexPath.row]];
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
    self.recordGestureVc.navigationItem.title = [[self.gestureSet.gestures allObjects] objectAtIndex:indexPath.row];
    [[self navigationController] pushViewController:self.recordGestureVc animated:YES];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
#warning TODO configure the cell properly
    NZGesture *gesture = [[self.gestureSet.gestures allObjects] objectAtIndex:indexPath.row];
    NSDate *date = [gesture valueForKey:@"timeStampCreated"];
    cell.textLabel.text = gesture.label.name;
}

#pragma mark - methods handling editing of the rable view cells
- (void)insertNewItem:(id)sender {
    [self presentViewController:self.popupVc animated:YES completion:nil];
    self.currentDate = [NSDate date];
    self.popupVc.timestampText.text = [self.currentDate description];
    self.popupVc.nameText.text = self.popupVc.timestampText.text;
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
    NZClassLabel *newClassLabel = [NSEntityDescription insertNewObjectForEntityForName:ENTITY_NAME_CLASS_LABEL inManagedObjectContext:context];
    [newClassLabel setValue:[form objectForKey:@"name"]forKey:@"name"];
    NSNumber *index = [NSNumber numberWithUnsignedInteger:[[NZClassLabel findAll]count]];
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
