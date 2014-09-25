//
//  MainGestureConfigurationVC.m
//  Gesture
//
//  Created by Natalia Zarawska on 9/25/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZMainGestureConfigurationVC.h"

#import "NZGesture.h"
#import "NZClassLabel.h"
#import "NZGestureSet.h"
#import "NZGestureSetHandler.h"

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

#pragma mark - IBActions

#pragma mark - Others
@property (retain, nonatomic) NZGestureSet *gestureSet;
@property (retain, nonatomic) NSArray *gesturesSorted;
@property (retain, nonatomic) NZGesture *selectedGesture;

@end

@implementation NZMainGestureConfigurationVC



- (void)viewDidLoad {
    [super viewDidLoad];
    self.gestureSet = [NZGestureSetHandler sharedManager].selectedGestureSet;
    NSSortDescriptor *gestureSortDescripor = [[NSSortDescriptor alloc] initWithKey:@"label.name" ascending:YES];
    self.gesturesSorted = [[self.gestureSet.gestures allObjects] sortedArrayUsingDescriptors:@[gestureSortDescripor]];
    // Do any additional setup after loading the view.
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



@end