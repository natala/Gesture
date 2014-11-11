//
//  NZStartScreenVC.m
//  Gesture
//
//  Created by Natalia Zarawska on 9/10/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZStartScreenVC.h"
#import "NZGestureSet+CoreData.h"
#import "NZGestureSet+CoreData.h"
#import "NZCoreDataManager.h"

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

- (void)viewWillDisappear:(BOOL)animated
{
    [self.activityIndicator stopAnimating];
    [super viewWillDisappear:animated];
}

- (void)presentAlert
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"done", nil];
    
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView textFieldAtIndex:0].placeholder = @"enter new gesture set name here";
    alertView.tag = 100;
    [alertView show];
}

- (void)didSelectGestureSet
{
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(startScreen:didSelectGestureSet:)]) {
            [self.delegate startScreen:self didSelectGestureSet:self.selectedSetName];
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];

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
}

#pragma mark - IBActions

- (IBAction)goButtonTapped:(UIButton *)sender {
   self.selectedSetName = [self pickerView:self.pickerView titleForRow:[self.pickerView selectedRowInComponent:0] forComponent:0];
    // if setting up a new gesture set
    if ([self.selectedSetName isEqualToString:kPickerRowNewName]) {
        [self presentAlert];
        return;
    } else {
        [self.activityIndicator startAnimating];
        [self didSelectGestureSet];
    }
}

- (IBAction)renameButtonTapped:(UIButton *)sender {
    self.selectedSetName = [self pickerView:self.pickerView titleForRow:[self.pickerView selectedRowInComponent:0] forComponent:0];
    if ([self.selectedSetName isEqual:kPickerRowNewName]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"wrong selection" message:@"new is used to create a new set" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"rename %@", self.selectedSetName ] delegate:self cancelButtonTitle:@"Done" otherButtonTitles: nil];
        alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        alertView.tag = 200;
        [alertView show];
    }
}

- (IBAction)deleteButtonTapped:(UIButton *)sender {
    self.selectedSetName = [self pickerView:self.pickerView titleForRow:[self.pickerView selectedRowInComponent:0] forComponent:0];
    if ([self.selectedSetName isEqual:kPickerRowNewName]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"wrong selection" message:@"new is used to create a new set" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
    } else {
        NZGestureSet *set = [NZGestureSet findWithName:self.selectedSetName];
        if (set) {
            [set destroy];
        }
    }
   // [self.pickerView reloadInputViews];
    [[NZCoreDataManager sharedManager] save];
    [self.pickerView reloadAllComponents];
}

#pragma mark - UI Alert View Delegate
// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 100 && buttonIndex == 1) {
        self.selectedSetName = [[alertView textFieldAtIndex:0] text];
        [self didSelectGestureSet];
    } else if (alertView.tag == 200) {
        NZGestureSet *set = [NZGestureSet findWithName:self.selectedSetName];
        if (set) {
            set.name = [[alertView textFieldAtIndex:0] text];
            self.selectedSetName = set.name;
            [[NZCoreDataManager sharedManager] save];
            [self.pickerView reloadAllComponents];
        } else NSLog(@"failed to change name. No set with the given name found");
    }
}

// Called when we cancel a view (eg. the user clicks the Home button). This is not called when the user clicks the cancel button.
// If not defined in the delegate, we simulate a click in the cancel button
- (void)alertViewCancel:(UIAlertView *)alertView
{

}

@end
