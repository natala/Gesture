//
//  NZMainSetTestingVC.m
//  Gesture
//
//  Created by Natalia Zarawska on 8/11/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZMainSetTestingVC.h"
#import "NZCoreDataManager.h"
#import "NZGesture+CoreData.h"
#import "NZClassLabel+CoreData.h"
#import "NZPipelineController.h"

@interface NZMainSetTestingVC ()

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (weak, nonatomic) IBOutlet UISegmentedControl *partitionRecordSegmentControl;
@property (weak, nonatomic) IBOutlet UILabel *instructionsLabel;

@property NSString *partitionInstruction;
@property NSString *recordInstruction;

@end

@implementation NZMainSetTestingVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
    
    self.partitionInstruction = @"insert the partition constant";
    self.recordInstruction = @"select the gesture above and record the testing set";
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //return [[self.fetchedResultsController sections] count];
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    //return [sectionInfo numberOfObjects];
    return [self.gestureSet.gestures count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GestureTestingCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GestureTestingCell"];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
#warning not yet implemented
    NSLog(@"selecting a row not yet implemented");
}


#pragma mark - Table view delegate

#pragma mark - Fetched results controller
- (NSFetchedResultsController *)fetchedResultsController
{
    if ( _fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    //NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:ENTITY_NAME_GESTURE];
    // Edit the entity name as appropriate.
    NSManagedObjectContext *context = [[NZCoreDataManager sharedManager] managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:ENTITY_NAME_GESTURE inManagedObjectContext:context];
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

#pragma mark -

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
#warning TODO configure the cell properly
    NZGesture *gesture = [[self.gestureSet.gestures allObjects] objectAtIndex:indexPath.row];
    NSDate *date = [gesture valueForKey:@"timeStampCreated"];
    cell.textLabel.text = gesture.label.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d samples", [gesture.positiveSamples count] ];
}

#pragma mark - IBActions

- (IBAction)partitionRecordSegmentControlChangedValue:(id)sender {
    
    if ([self.partitionRecordSegmentControl selectedSegmentIndex] == 0) {
        self.instructionsLabel.text = self.partitionInstruction;
        self.partitionConstantTextField.hidden = false;
    } else {
        self.instructionsLabel.text = self.recordInstruction;
        self.partitionConstantTextField.hidden = true;
    }
}

- (IBAction)didEdidPartitionConstatntTextField:(id)sender {
    int partitionConstant = [self.partitionConstantTextField.text integerValue];
    if (partitionConstant > 100) {
        partitionConstant = 100;
        self.partitionConstantTextField.text = [NSString stringWithFormat:@"%d", partitionConstant];
    } else if (partitionConstant < 0) {
        partitionConstant = 0;
        self.partitionConstantTextField.text = [NSString stringWithFormat:@"%d", partitionConstant];
    }
}

- (IBAction)testTapped:(id)sender {
    NSDictionary *testResults = [[NZPipelineController sharedManager] testPipeline:[self.partitionConstantTextField.text integerValue]];
    NSString *resultsAsString = [NSString stringWithFormat:@"%@", testResults];
    self.testReportTextView.text = resultsAsString;
}

@end
