//
//  MainGestureConfigurationVC.m
//  Gesture
//
//  Created by Natalia Zarawska on 9/25/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZMainGestureConfigurationVC.h"

#import "NZGesture+CoreData.h"
#import "NZClassLabel+CoreData.h"
#import "NZGestureSet.h"

#import "NZGestureSetHandler.h"
#import "NZPipelineController.h"

#import "NZEditGestureSamplesTVC.h"

#import "NZCoreDataManager.h"

@interface NZMainGestureConfigurationVC ()

#pragma mark - UI elements

@property (weak, nonatomic) IBOutlet UIPickerView *gesturePickerView;
@property (weak, nonatomic) IBOutlet UIButton *plusButton;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;

@property (weak, nonatomic) IBOutlet UIButton *samplesButton;
@property (weak, nonatomic) IBOutlet UIButton *actionsButton;
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;
@property (weak, nonatomic) IBOutlet UIButton *checkButton;

@property (weak, nonatomic) IBOutlet UIButton *gestureRecordingButton;

#pragma mark - UI Popovers
@property (retain, nonatomic) UIPopoverController *samplesPopoverController;
@property (retain, nonatomic) UIPopoverController *cameraPopoverController;
@property (retain, nonatomic) UIPopoverController *checkPopoverController;

#pragma mark - UI Alert Controller
@property (retain, nonatomic) UIAlertController *addGestureAlertController;

#pragma mark - Others
@property (retain, nonatomic) NZGestureSet *gestureSet;
@property (retain, nonatomic) NSArray *gesturesSorted;
@property (retain, nonatomic) NZGesture *selectedGesture;

@end

@implementation NZMainGestureConfigurationVC



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.gestureSet = [NZGestureSetHandler sharedManager].selectedGestureSet;
    [self updateGestureSet];
    
    [super viewDidLayoutSubviews];
    
    // Configure the UI elements
    //  * the samples number
    self.samplesButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    NSUInteger sampleNumber = [[NZPipelineController sharedManager] numberOfSamplesForClassLabelIndex:self.selectedGesture.label.index];
    NSMutableString *samplesButtonText = [NSMutableString stringWithFormat:@"%d",sampleNumber];
    [samplesButtonText appendString:@"\nSamples"];
    [self.samplesButton setTitle:samplesButtonText forState:UIControlStateNormal];
    
    // Configure the Popovers
    //  * Samples
     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NZEditGestureSamplesTVC *samplesVC = [storyboard instantiateViewControllerWithIdentifier:@"GestureSamplesTVC"];
    self.samplesPopoverController = [[UIPopoverController alloc] initWithContentViewController:samplesVC];
    self.samplesPopoverController.delegate = self;
    //  * Camera
    self.cameraPopoverController = [[UIPopoverController alloc] initWithContentViewController:samplesVC];
    self.cameraPopoverController.delegate = self;
    //  * Check
    self.checkPopoverController = [[UIPopoverController alloc] initWithContentViewController:samplesVC];
    self.checkPopoverController.delegate = self;
    
    // Configure others
    self.addGestureAlertController = [UIAlertController alertControllerWithTitle:@"Add new gesture" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *doneAction = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self addGestureFromAllertViewController];
    }];
    [self.addGestureAlertController addAction:doneAction];
    [self.addGestureAlertController addAction:cancelAction];
    [self.addGestureAlertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Enter gesture name here";
    }];
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
    return [self.gestureSet.gestures count];
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
    NZGesture *gesture = [self.gesturesSorted objectAtIndex:row];
    NZClassLabel *label = gesture.label;
    return label.name;
}

/*
 pickerView:attributedTitleForRow:forComponent:
 pickerView:viewForRow:forComponent:reusingView:
*/

// Responding to Row Selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedGesture = [self.gesturesSorted objectAtIndex:row];
}

#pragma mark - getters & setters
- (void)setSelectedGesture:(NZGesture *)selectedGesture
{
    _selectedGesture = selectedGesture;
}


#pragma mark - IB Actions

- (IBAction)samplesButtonTapped:(UIButton *)sender {
    NZEditGestureSamplesTVC *vc = (NZEditGestureSamplesTVC *)self.samplesPopoverController.contentViewController;
    vc.gesture = self.selectedGesture;
    [self.samplesPopoverController presentPopoverFromRect:sender.bounds inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)cameraButtonTapped:(UIButton *)sender {
    [self.cameraPopoverController presentPopoverFromRect:sender.bounds inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)checkButtonTapped:(UIButton *)sender {
    [self.checkPopoverController presentPopoverFromRect:sender.bounds inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)plusButtonTapped:(UIButton *)sender {
    [self presentViewController:self.addGestureAlertController animated:YES completion:nil];
}

- (IBAction)minusButtonTapped:(UIButton *)sender {
}


#pragma mark - UI Popover Contoller Delegate
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    if ([popoverController isEqual:self.samplesPopoverController]) {
        // update the button sample number
        self.samplesButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        NSUInteger sampleNumber = [[NZPipelineController sharedManager] numberOfSamplesForClassLabelIndex:self.selectedGesture.label.index];
        NSMutableString *samplesButtonText = [NSMutableString stringWithFormat:@"%d",sampleNumber];
        [samplesButtonText appendString:@"\nSamples"];
        [self.samplesButton setTitle:samplesButtonText forState:UIControlStateNormal];
    }
}

#pragma mark - managing the gestures
- (void)addGestureFromAllertViewController
{
    UITextField *textField = [self.addGestureAlertController.textFields objectAtIndex:0];
    
    if ([textField.text isEqualToString:@""]) {
        return;
    }
    if ([NZClassLabel existsWithName:textField.text]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"a gesture with the given name already exists" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    NZClassLabel *lastClassObject = [NZClassLabel findLates];
    NSNumber *index = [NSNumber numberWithInt:1];
    if (lastClassObject) {
        index = [NSNumber numberWithInt:[lastClassObject.index intValue]+1 ];
    }
    
    NZClassLabel *newClassLabel = [NZClassLabel create];
    newClassLabel.name = textField.text;
    newClassLabel.index = index;
    
    NZGesture *newGesture = [NZGesture create];
    newGesture.label = newClassLabel;
    newGesture.timeStampCreated = [NSDate date];
    newGesture.timeStampUpdated = newGesture.timeStampCreated;
    
    [self.gestureSet addGesturesObject:newGesture];
    
    NZCoreDataManager *manager = [NZCoreDataManager sharedManager];
    [manager save];
   /* 
     NSError *error = nil;
    if ([[NZCoreDataManager sharedManager] save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }*/
    [self updateGestureSet];
    [self.gesturePickerView reloadAllComponents];
    
    
}

#pragma mark - Helper Functions
- (void)updateGestureSet
{
    NSSortDescriptor *gestureSortDescripor = [[NSSortDescriptor alloc] initWithKey:@"label.name" ascending:YES];
    self.gesturesSorted = [[self.gestureSet.gestures allObjects] sortedArrayUsingDescriptors:@[gestureSortDescripor]];
}

@end