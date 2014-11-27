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
#import "NZActionComposite+CoreData.h"
#import "NZCoreDataManager.h"
#import "NZLocation+CoreData.h"
#import "NZClassLabel.h"

@interface NZGestureActionMappingVC ()

#pragma mark - Location Related
@property (nonatomic, strong) NZLocation *selectedLocation;
@property (nonatomic, strong) NSArray *allLocations;

#pragma mark - UI Elements
@property (weak, nonatomic) IBOutlet UIPickerView *singleActionsPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *groupActionsPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *loctionPickerView;

#pragma mark - Gesture Related

#pragma mark - Actions Related
@property (retain, nonatomic) NZAction *selectedSingleAction;
@property (retain, nonatomic) NZAction *selectedGroupAction;
@property (nonatomic, strong) NSArray *allSingleActionsForLocation;
@property (nonatomic, strong) NSArray *allGroupActionsForLocation;
//@property (retain, nonatomic) NSArray *allSingleActions;
//@property (retain, nonatomic) NSArray *allActions;

@end

@implementation NZGestureActionMappingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.allSingleActions = [NZSingleAction findAllSortedByName];
    //self.allActions = [NZAction findAllSortedByName];
    
    self.allLocations = [NZLocation findAllSortedByName];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    // Configure picker views
    //  * single    //
    
  /*  NZAction *singleAction = self.selectedGesture.singleAction;
    NSUInteger singleIndex;
    if (singleAction) {
        singleIndex = [self.allSingleActions indexOfObject:singleAction];
    } else {
        singleIndex = [self.allSingleActions count];
    }
    [self.singleActionsPickerView selectRow:singleIndex inComponent:0 animated:NO];
    */
    
    //  * group     //
    /*
    NZAction *groupAction = self.selectedGesture.actionComposite;
    NSUInteger groupIndex;
    if (groupAction) {
        groupIndex = [self.allActions indexOfObject:groupAction];
    } else {
        groupIndex = [self.allActions count];
    }
    [self.groupActionsPickerView selectRow:groupIndex inComponent:0 animated:NO];
    */
    //  * locations     //
    if ([self.allLocations count] == 1) {
        self.selectedLocation = [self.allLocations objectAtIndex:0];
    } else if ([self.allLocations count] > 0) {
        for (int i = 0; i < [self.allLocations count]; i++) {
            NZLocation *location = [self.allLocations objectAtIndex:i];
            if ([location.action count] > 0) {
                [self.loctionPickerView selectRow:i inComponent:0 animated:NO];
                self.selectedLocation = [self.allLocations objectAtIndex:i];
                break;
            }
        }
    }
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
         return [self.allSingleActionsForLocation count]+1;
        
    } else if ([pickerView isEqual:self.groupActionsPickerView]) {
        return [self.allGroupActionsForLocation count]+1;
    } else if ([pickerView isEqual:self.loctionPickerView]) {
        return [self.allLocations count];
    }
    return 0;
}

#pragma mark - UI Picker View Delegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if ([pickerView isEqual:self.singleActionsPickerView]) {
        if (row == [self.allSingleActionsForLocation count]) {
            return @"none";
        }
        NZAction *action = [self.allSingleActionsForLocation objectAtIndex:row];
        return action.name;
    }
    if ([pickerView isEqual:self.groupActionsPickerView]) {
        if (row == [self.allGroupActionsForLocation count]) {
            return @"none";
        }
        NZAction *action = [self.allGroupActionsForLocation objectAtIndex:row];
        return action.name;
    }
    if ([pickerView isEqual:self.loctionPickerView]) {
        NZLocation *location = [self.allLocations objectAtIndex:row];
        return location.name;
    }
    return nil;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([pickerView isEqual:self.singleActionsPickerView]) {
        NSUInteger selectedAction = [self.singleActionsPickerView selectedRowInComponent:0];
        if (self.selectedSingleAction) {
            [self.selectedGesture removeSingleActionObject:self.selectedSingleAction];
        }
        
        // self.selectedGesture.singleAction = nil;
        if (selectedAction < [self.allSingleActionsForLocation count]) {
            NZAction *action = [self.allSingleActionsForLocation objectAtIndex:selectedAction];
            //self.selectedGesture.singleAction = (NZSingleAction *)action;
            [self.selectedGesture addSingleActionObject:(NZSingleAction*)action];
            self.selectedSingleAction = action;
        }
    } else if ([pickerView isEqual:self.groupActionsPickerView]) {
        NSUInteger selectedAction = [self.groupActionsPickerView selectedRowInComponent:0];
        
        if (self.selectedGroupAction) {
            [self.selectedGesture removeActionCompositeObject:self.selectedGroupAction];
        }
        //self.selectedGesture.actionComposite = nil;
        if (selectedAction < [self.allGroupActionsForLocation count]) {
            NZAction *action = [self.allGroupActionsForLocation objectAtIndex:selectedAction];
            //self.selectedGesture.actionComposite = action;
            [self.selectedGesture addActionCompositeObject:action];
            self.selectedGroupAction = action;
        }
    } else if ([pickerView isEqual:self.loctionPickerView]) {
        self.selectedLocation = [self.allLocations objectAtIndex:row];
    }
    
    NZCoreDataManager *manager = [NZCoreDataManager sharedManager];
    [manager save];
}

#pragma mark - setters & getters
- (void)setSelectedLocation:(NZLocation *)selectedLocation
{
    _selectedLocation = selectedLocation;
    
    self.allSingleActionsForLocation = [NZSingleAction findAllSortedByNameActionsForLocation:selectedLocation.name];
    self.allGroupActionsForLocation = [NZActionComposite findAllSortedByNameActionsForLocation:selectedLocation.name];
    
 //   [self.singleActionsPickerView selectRow:singleIndex inComponent:0 animated:NO];
    
    [self.singleActionsPickerView reloadAllComponents];
    [self.groupActionsPickerView reloadAllComponents];
    
    
    NZSingleAction *singleAction = [NZSingleAction findActionForLocation:self.selectedLocation.name andGesture:self.selectedGesture.label.name];
    
    NSUInteger singleIndex;
    if (singleAction) {
        singleIndex = [self.allSingleActionsForLocation indexOfObject:singleAction];
    } else {
        singleIndex = [self.allSingleActionsForLocation count];
    }
    self.selectedSingleAction = singleAction;
    [self.singleActionsPickerView selectRow:singleIndex inComponent:0 animated:NO];
    
    NZActionComposite *groupAction = [NZActionComposite findActionForLocation:self.selectedLocation.name andGesture:self.selectedGesture.label.name];
    
    NSUInteger groupIndex;
    if (groupAction) {
        groupIndex = [self.allGroupActionsForLocation indexOfObject:groupAction];
    } else {
        groupIndex = [self.allGroupActionsForLocation count];
    }
    self.selectedGroupAction = groupAction;
    [self.groupActionsPickerView selectRow:groupIndex inComponent:0 animated:NO];
}

#pragma mark - Helper Methods

@end
