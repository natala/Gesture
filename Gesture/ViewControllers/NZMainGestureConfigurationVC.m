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

@property (weak, nonatomic) IBOutlet UIButton *connectButton;

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

@property BOOL isRecordingGesture;

@end

@implementation NZMainGestureConfigurationVC



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.gestureSet = [NZGestureSetHandler sharedManager].selectedGestureSet;
    [self updateGestureSet];
    
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
    
    self.isRecordingGesture = false;
}

- (void)viewDidLayoutSubviews
{
    if (!self.selectedGesture && [self.gesturePickerView numberOfRowsInComponent:0] > 0) {
        [self.gesturePickerView selectRow:0 inComponent:0 animated:NO];
        self.selectedGesture = [self.gesturesSorted objectAtIndex:0];
    }
    self.connectButton.hidden = false;
    self.gestureRecordingButton.hidden = true;
    self.gestureRecordingButton.highlighted = false;
    [self updateSamplesButton];
    
    if ([self.gestureSet.gestures count] == 0) {
        // there are not gestures!
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Add Gestures" message:@"You have no gestures configured yet" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *addAction = [UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self presentViewController:self.addGestureAlertController animated:YES completion:nil];
        }];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Not now" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:addAction];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if ([NZPipelineController sharedManager].pipelineHasToBeTrained) {
        [[NZPipelineController sharedManager] trainClassifier];
    }
    [[NZSensorDataRecordingManager sharedManager] disconnect];
    [[NZSensorDataRecordingManager sharedManager] removeRecordingObserver:self];
    self.gestureRecordingButton.hidden = true;
    self.gestureRecordingButton.highlighted = false;
    self.connectButton.hidden = false;
    
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
    [self reloadGestureSpecificComponents];
}


#pragma mark - IB Actions

- (IBAction)samplesButtonTapped:(UIButton *)sender {
    NZEditGestureSamplesTVC *vc = (NZEditGestureSamplesTVC *)self.samplesPopoverController.contentViewController;
    vc.delegate = self;
    vc.gesture = self.selectedGesture;
    [self.samplesPopoverController presentPopoverFromRect:sender.bounds inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)cameraButtonTapped:(UIButton *)sender {
    [self.cameraPopoverController presentPopoverFromRect:sender.bounds inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)checkButtonTapped:(UIButton *)sender {
    if ([NZPipelineController sharedManager].pipelineHasToBeTrained) {
        [[NZPipelineController sharedManager] trainClassifier];
    }
    [self.checkPopoverController presentPopoverFromRect:sender.bounds inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)plusButtonTapped:(UIButton *)sender {
    [self presentViewController:self.addGestureAlertController animated:YES completion:nil];
}

- (IBAction)minusButtonTapped:(UIButton *)sender {
 
    UIAlertController *areYouSureAlert = [UIAlertController alertControllerWithTitle:@"Are you sure you want to delete selected gesture?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self deleteCurrentGesture];
    }];
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:nil];
    [areYouSureAlert addAction:yesAction];
    [areYouSureAlert addAction:noAction];
    [self presentViewController:areYouSureAlert animated:YES completion:nil];
}

- (IBAction)connectButtonTapped:(UIButton *)sender
{
    if (![[NZSensorDataRecordingManager sharedManager].sensorDataRecordingObservers containsObject:self]) {
        [[NZSensorDataRecordingManager sharedManager] addRecordingObserver:self];
    }
    [[NZSensorDataRecordingManager sharedManager] prepareForRecordingSensorDataSet];
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
        // check if deleted any samples
        if ([self.selectedGesture.positiveSamples count] != [[NZPipelineController sharedManager]numberOfSamplesForClassLabelIndex:self.selectedGesture.label.index]) {
            [[NZPipelineController sharedManager] reloadTrainingSamplesForGesture:self.selectedGesture];
        }
        [self updateSamplesButton];
    }
}

#pragma mark - NZ ensor Data Recording Manager Observer methods
- (void)disconnected
{
    self.gestureRecordingButton.enabled = false;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"PowerRing Disconnected" message:@"Check if the PowerRing is on" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
    self.gestureRecordingButton.hidden = true;
    self.connectButton.hidden = false;
}


- (void)connected
{
    self.gestureRecordingButton.hidden = false;
    self.connectButton.hidden = true;
}

- (void)didStartRecordingSensorData:(NZSensorDataSet *) sensorDataSet
{
    NSLog(@"Sensor Data Recording Manager did start recording");
}

- (void)didPauseReordingSensorData:(NZSensorDataSet *) sensorDataSet
{
    NSLog(@"Sensor Data Recording Manager did pasue recording");
}

- (void)didResumeRecordingSensorData:(NZSensorDataSet *) sensorDataSet
{
    //NSLog(@"Sensor Data Recording Manager did resume recording");
}

- (void)didReceiveSensorData:(NZSensorData *) sensorData forSensorDataSet:(NZSensorDataSet *) sensorDataSet
{
    NSLog(@"Sensor Data Recording Manager did receive sensor data");
}

- (void)didStopRecordingSensorDataSet:(NZSensorDataSet *) sensorDataSet
{
    NSLog(@"Sensor Data Recording Manager did stop recording");
    // once done, correlate it find with the geture as a positive sample
    [self.selectedGesture addPositiveSamplesObject:sensorDataSet];
    
    // update the database
    [[NZCoreDataManager sharedManager] save];
    
    // update the classifier with the new sample
    if ([sensorDataSet.sensorData count] > 0) {
        [[NZPipelineController sharedManager] addPositive:YES sample:sensorDataSet withLabel:self.selectedGesture.label];
    }
}

- (void)buttonStateDidChangeFrom:(ButtonState)previousState to:(ButtonState)currentButtonState
{
    if (self.isRecordingGesture && currentButtonState == BUTTON_SHORT_PRESS) {
        // stop recording the gesture
        [[NZSensorDataRecordingManager sharedManager] stopRecordingCurrentSensorDataSet];
        if (([self.selectedGesture.positiveSamples count] > 0) || ([self.selectedGesture.negativeSamples count] > 0)) {
           // self.learnGestureButton.enabled = true;
        }
        self.isRecordingGesture = false;
        [self updateSamplesButton];
        self.isRecordingGesture = false;
        self.gestureRecordingButton.highlighted = false;
        [self changeEanbledStateOfControllButtonsTo:true];
        
    } else if (!self.isRecordingGesture && currentButtonState == BUTTON_SHORT_PRESS){
        // start recording the gesture
        BOOL startedNewRecording = [[NZSensorDataRecordingManager sharedManager] startRecordingNewSensorDataSet];
        if (startedNewRecording) {
            self.isRecordingGesture = true;
            self.gestureRecordingButton.highlighted = true;
            // disable all buttons
            [self changeEanbledStateOfControllButtonsTo:false];
        }
    } else if (!self.isRecordingGesture && currentButtonState == BUTTON_LONG_PRESS) {
        ;
    } else if (!self.isRecordingGesture && currentButtonState == BUTTON_DOUBLE_PRESS) {
        ;
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
    [self updateGestureSet];
    [self.gesturePickerView reloadAllComponents];
    
}

- (void)deleteCurrentGesture
{
    [[NZPipelineController sharedManager] removeClassLabel:self.selectedGesture.label];
    [self.selectedGesture destroy];
    
    NZCoreDataManager *manager = [NZCoreDataManager sharedManager];
    [manager save];
    
    [self updateGestureSet];
    [self.gesturePickerView reloadAllComponents];
    
}

#pragma mark - Helper Functions
- (void)updateGestureSet
{
    NSSortDescriptor *gestureSortDescripor = [[NSSortDescriptor alloc] initWithKey:@"label.name" ascending:YES];
    self.gesturesSorted = [[self.gestureSet.gestures allObjects] sortedArrayUsingDescriptors:@[gestureSortDescripor]];
}

- (void)reloadGestureSpecificComponents
{
    [self updateSamplesButton];
}

- (void)updateSamplesButton
{
    self.samplesButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    NSUInteger sampleNumber = [[NZPipelineController sharedManager] numberOfSamplesForClassLabelIndex:self.selectedGesture.label.index];
    NSMutableString *samplesButtonText = [NSMutableString stringWithFormat:@"%d",sampleNumber];
    [samplesButtonText appendString:@"\nSamples"];
    [self.samplesButton setTitle:samplesButtonText forState:UIControlStateNormal];
}

- (void)changeEanbledStateOfControllButtonsTo:(BOOL)state
{
    self.samplesButton.enabled = state;
    self.actionsButton.enabled = state;
    self.cameraButton.enabled = state;
    self.checkButton.enabled = state;
    self.plusButton.enabled = state;
    self.minusButton.enabled = state;
}

#pragma mark -  NZEditingGestureSamplesTVCDelegare
- (void)didDeleteSample
{
 //   [self updateGestureSet];
 //   [self updateSamplesButton];
}

@end