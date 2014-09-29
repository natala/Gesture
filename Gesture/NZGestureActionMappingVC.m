//
//  NZGestureActionMappingVC.m
//  Gesture
//
//  Created by Natalia Zarawska on 9/26/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZGestureActionMappingVC.h"
#import "NZGesture.h"
#import "NZAction+CoreData.h"
#import "NZSingleAction+CoreData.h"
#import "NZCoreDataManager.h"

@interface NZGestureActionMappingVC ()

#pragma mark - UI Elements
@property (weak, nonatomic) IBOutlet UIPickerView *singleActionsPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *groupActionsPickerView;

#pragma mark - Gesture Related

#pragma mark - Actions Related
@property (retain, nonatomic) NZAction *selectedSingleAction;
@property (retain, nonatomic) NZAction *selectedGroupAction;
@property (retain, nonatomic) NSArray *allSingleActions;
@property (retain, nonatomic) NSArray *allActions;

@end

@implementation NZGestureActionMappingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.allSingleActions = [NZSingleAction findAllSortedByName];
    self.allActions = [NZAction findAllSortedByName];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    // Configure picker views
    //  * single
    NZAction *singleAction = self.selectedGesture.singleAction;
    NSUInteger singleIndex;
    if (singleAction) {
        singleIndex = [self.allSingleActions indexOfObject:singleAction];
    } else {
        singleIndex = [self.allSingleActions count];
    }
    [self.singleActionsPickerView selectRow:singleIndex inComponent:0 animated:NO];
    
    NZAction *groupAction = self.selectedGesture.actionComposite;
    NSUInteger groupIndex;
    if (groupAction) {
        groupIndex = [self.allActions indexOfObject:groupAction];
    } else {
        groupIndex = [self.allActions count];
    }
    [self.groupActionsPickerView selectRow:groupIndex inComponent:0 animated:NO];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - IB Actions

- (IBAction)moreButtonTapped:(UIButton *)sender {

    if (self.delegate && [self.delegate respondsToSelector:@selector(didTapMoreButton)]) {
        [self.delegate didTapMoreButton];
    }

}

#pragma mark - UI Picker View Data Source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (!self.selectedGesture) {
        return 0;
    }
    if ([pickerView isEqual:self.singleActionsPickerView]) {
         return [self.allSingleActions count]+1;
        
    } else if ([pickerView isEqual:self.groupActionsPickerView]) {
        return [self.allActions count]+1;
    }
    return 0;
}

#pragma mark - UI Picker View Delegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if ([pickerView isEqual:self.singleActionsPickerView]) {
        if (row == [self.allSingleActions count]) {
            return @"none";
        }
        NZAction *action = [self.allSingleActions objectAtIndex:row];
        return action.name;
    }
    if ([pickerView isEqual:self.groupActionsPickerView]) {
        if (row == [self.allActions count]) {
            return @"none";
        }
        NZAction *action = [self.allActions objectAtIndex:row];
        return action.name;
    }
    return nil;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([pickerView isEqual:self.singleActionsPickerView]) {
        NSUInteger selectedAction = [self.singleActionsPickerView selectedRowInComponent:0];
        self.selectedGesture.singleAction = nil;
        if (selectedAction < [self.allSingleActions count]) {
            NZAction *action = [self.allSingleActions objectAtIndex:selectedAction];
            self.selectedGesture.singleAction = (NZSingleAction *)action;
        }
    } else if ([pickerView isEqual:self.groupActionsPickerView]) {
        NSUInteger selectedAction = [self.groupActionsPickerView selectedRowInComponent:0];
        self.selectedGesture.actionComposite = nil;
        if (selectedAction < [self.allActions count]) {
            NZAction *action = [self.allActions objectAtIndex:selectedAction];
            self.selectedGesture.actionComposite = action;
        }
    }
    
    NZCoreDataManager *manager = [NZCoreDataManager sharedManager];
    [manager save];
}

#pragma mark - Helper Methods


@end
