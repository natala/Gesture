//
//  NZFeedbackVC.m
//  Gesture
//
//  Created by Natalia Zarawska on 9/29/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZFeedbackVC.h"
#import "NZGestureSetHandler.h"
#import "NZClassLabel.h"

@interface NZFeedbackVC ()

@property (retain, nonatomic) NSArray *gesturesSorted;
@property (weak, nonatomic) IBOutlet UIPickerView *gesturesPickerView;

@end

@implementation NZFeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSSortDescriptor *gestureSortDescripor = [[NSSortDescriptor alloc] initWithKey:@"label.name" ascending:YES];
    NZGestureSet *currentSet = [NZGestureSetHandler sharedManager].selectedGestureSet;
    self.gesturesSorted = [[currentSet.gestures allObjects] sortedArrayUsingDescriptors:@[gestureSortDescripor]];

    // Do any additional setup after loading the view.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if ([self.gesturesPickerView numberOfRowsInComponent:0] > 1) {
        [self.gesturesPickerView selectRow:[self.gesturesPickerView numberOfRowsInComponent:0]-1 inComponent:0 animated:NO];
    }
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

#pragma mark - UI Picker Data Soutce

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.gesturesSorted count] + 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (row == [self.gesturesSorted count]) {
        return @"none";
    }
    NZGesture *gesture = [self.gesturesSorted objectAtIndex:row];
    return gesture.label.name;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

#pragma mark - UI Picker Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (row == [self.gesturesSorted count]) {
        self.correctGesture = nil;
    } else {
        self.correctGesture = [self.gesturesSorted objectAtIndex:row];
    }
}

#pragma mark - IB Actions

- (IBAction)doneButtonTapped:(UIButton *)sender {
    NSInteger selectedIndex = [self.gesturesPickerView selectedRowInComponent:0];
    BOOL update = false;
    if (selectedIndex < [self.gesturesSorted count] && selectedIndex >= 0) {
        update = true;
    }
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(shouldDismissVc:withAndCorrectRecognition:)]) {
            [self.delegate shouldDismissVc:self withAndCorrectRecognition:update];
        }
    }
}

- (IBAction)cancelButtonTapped:(UIButton *)sender {
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(shouldDismissVc:withAndCorrectRecognition:)]) {
            [self.delegate shouldDismissVc:self withAndCorrectRecognition:false];
        }
    }
}
@end
