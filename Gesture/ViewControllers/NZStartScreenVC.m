//
//  NZStartScreenVC.m
//  Gesture
//
//  Created by Natalia Zarawska on 9/10/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZStartScreenVC.h"
#import "NZGestureSet+CoreData.h"

static NSString *kPickerRowNewName = @"new";

@interface NZStartScreenVC ()

@property (nonatomic, retain) NSString *selectedSetName;

@end

@implementation NZStartScreenVC

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
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
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

#pragma mark - UI Picker View Data Source Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [[NZGestureSet findAll] count]+1;
}

#pragma mark - UI Picker View Delegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSArray *sets = [NZGestureSet findAllSortetByLabel];
    if ([sets count] == row) {
        return kPickerRowNewName;
    }
    NZGestureSet *set = [sets objectAtIndex:row];
    return  set.name;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedSetName = [self pickerView:pickerView titleForRow:row forComponent:component];
    if ([self.selectedSetName isEqualToString:kPickerRowNewName]) {
        self.selectedSetName = nil;
    }
}

- (IBAction)goButtonTapped:(UIButton *)sender {
    
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(startScreen:didSelectGestureSet:)]) {
            [self.delegate startScreen:self didSelectGestureSet:self.selectedSetName];
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
