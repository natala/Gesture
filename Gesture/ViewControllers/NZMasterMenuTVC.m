//
//  NZMasterMenuTVC.m
//  Gesture
//
//  Created by Natalia Zarawska on 6/26/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZMasterMenuTVC.h"
#import "NZDetailViewController.h"
#import "NZGestureSetHandler.h"
#import "NZRingConnectionVc.h"

@interface NZMasterMenuTVC ()

@property NSArray *items;
@property UITableViewCell *selectedCell;
@property BOOL hideStartScreen;

@property (nonatomic, retain) UIBarButtonItem *connectedRing;
@property (nonatomic, retain) UIBarButtonItem *disconnectedRing;

@property (nonatomic, retain) UIPopoverController *ringConnectionPopoverController;

@end

@implementation NZMasterMenuTVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [self commonInit];
        // Custom initialization
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return  self;
}

- (void)commonInit
{
    self.connectedRing = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"check_circle_small"] style:UIBarButtonItemStylePlain target:self action:@selector(connectionStatusTapped)];
    //self.connectedRing = [[UIBarButtonItem alloc] initWithTitle:@"Ȯ" style:UIBarButtonItemStylePlain target:self action:@selector(connectionStatusTapped)];
    self.disconnectedRing = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"delete_circle_small"] style:UIBarButtonItemStylePlain target:self action:@selector(connectionStatusTapped)];
    //self.disconnectedRing = [[UIBarButtonItem alloc] initWithTitle:@"U" style:UIBarButtonItemStylePlain target:self action:@selector(connectionStatusTapped)];

    [self.navigationItem setLeftBarButtonItem:self.disconnectedRing];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    self.ringConnectionPopoverController = [[UIPopoverController alloc] initWithContentViewController:[storyboard instantiateViewControllerWithIdentifier:@"RingConnectionPopoverVC"]];
    self.ringConnectionPopoverController.delegate = self;
    
  //  [[NZArduinoCommunicationManager sharedManager] addArduinoCommunicationObserver:self];
    [[NZBeanConnectionManager sharedManager] addBeanConnectionObserver:self];
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NZStartScreenVC *startScreen = (NZStartScreenVC *)[mainStoryBoard instantiateViewControllerWithIdentifier:@"StartScreenVC"];
    self.startScreenVc = startScreen;
    self.startScreenVc.delegate = self;
    self.hideStartScreen = false;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:self.configureCell];
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self presentStartScreenAnimated:NO];
}

- (void)viewDidLayoutSubviews
{
    self.selectedCell.highlighted = true;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidLayoutSubviews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)presentStartScreenAnimated:(BOOL)animated
{
    if (self.hideStartScreen) {
        return;
    }
    [self presentViewController:self.startScreenVc animated:animated completion:nil];
    [self.navigationController popToRootViewControllerAnimated:NO];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 5;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectedCell) {
        self.selectedCell.highlighted = NO;
    }
    if ([[tableView cellForRowAtIndexPath:indexPath] isEqual:self.leaveCell]) {
        self.hideStartScreen = false;
        [self presentStartScreenAnimated:YES];
    } else self.selectedCell = [tableView cellForRowAtIndexPath:indexPath];
}


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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.splitViewController.delegate = segue.destinationViewController;
}

#pragma mark - NZ Start Screen VC delegate
- (void)startScreen:(NZStartScreenVC *)startScreen didSelectGestureSet:(NSString *)gestureSetName
{
    self.hideStartScreen = true;
    NSLog(@"selected set: %@", gestureSetName);
    [[NZGestureSetHandler sharedManager] loadGestureSetWithName:gestureSetName];
    if ([[[NZGestureSetHandler sharedManager] selectedGestureSet].gestures count]) {
        [self.tableView selectRowAtIndexPath:[self.tableView indexPathForCell:self.mainControlCell] animated:NO scrollPosition:UITableViewScrollPositionNone];
        self.selectedCell = self.mainControlCell;
        [self performSegueWithIdentifier:@"mainControlSegue" sender:self];
        
    } else {
        [self.tableView selectRowAtIndexPath:[self.tableView indexPathForCell:self.configureCell] animated:NO scrollPosition:UITableViewScrollPositionNone];
        self.selectedCell = self.configureCell;
        [self performSegueWithIdentifier:@"configurationSegue" sender:self];
    }
   // self.startScreenVc.delegate = nil;
    self.selectedCell.highlighted = true;

}

#pragma mark -
- (void)connectionStatusTapped {
    NSLog(@"Tapped connection status button");
    if (![self.ringConnectionPopoverController isPopoverVisible]) {
        [self.ringConnectionPopoverController presentPopoverFromBarButtonItem:[self.navigationItem leftBarButtonItem] permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
}

#pragma mark - Bean Connection Manager Observer methods

- (void)beanConnectionManagerDidConnected
{
    [self.navigationItem setLeftBarButtonItem:self.connectedRing];
    UIViewController *vc = [self.ringConnectionPopoverController contentViewController];
    if ([vc isKindOfClass:[NZRingConnectionVc class]]) {
        NZRingConnectionVc* ringVc = (NZRingConnectionVc *)vc;
        ringVc.connectionStatusText = @"is connected";
    }
}

- (void)beanConnectionManagerDidDisconnectConnect
{
    [self.navigationItem setLeftBarButtonItem:self.disconnectedRing];
    UIViewController *vc = [self.ringConnectionPopoverController contentViewController];
    if ([vc isKindOfClass:[NZRingConnectionVc class]]) {
        NZRingConnectionVc* ringVc = (NZRingConnectionVc *)vc;
        ringVc.connectionStatusText = @"is not connected";
    }
    
    if (![self.ringConnectionPopoverController isPopoverVisible]) {
        [self.ringConnectionPopoverController presentPopoverFromBarButtonItem:[self.navigationItem leftBarButtonItem] permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
    
}


#pragma mark - Arduino Connection Manager Observer methods
/*
- (void)arduinoCommunicationManagerDidConnect
{
    [self.navigationItem setLeftBarButtonItem:self.connectedRing];
    UIViewController *vc = [self.ringConnectionPopoverController contentViewController];
    if ([vc isKindOfClass:[NZRingConnectionVc class]]) {
        NZRingConnectionVc* ringVc = (NZRingConnectionVc *)vc;
        ringVc.connectionStatusText = @"is connected";
    }
}

- (void)arduinoCommunicationManagerDidDisconnectConnect
{
    [self.navigationItem setLeftBarButtonItem:self.disconnectedRing];
    UIViewController *vc = [self.ringConnectionPopoverController contentViewController];
    if ([vc isKindOfClass:[NZRingConnectionVc class]]) {
        NZRingConnectionVc* ringVc = (NZRingConnectionVc *)vc;
        ringVc.connectionStatusText = @"is not connected";
    }
    
    if (![self.ringConnectionPopoverController isPopoverVisible]) {
        [self.ringConnectionPopoverController presentPopoverFromBarButtonItem:[self.navigationItem leftBarButtonItem] permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
}
 */
@end
