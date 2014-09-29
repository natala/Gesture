//
//  NZConfigurationNavigationController.m
//  Gesture
//
//  Created by Natalia Zarawska on 9/26/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZConfigurationNavigationController.h"
#import "NZMainConfigurationVC.h"

@interface NZConfigurationNavigationController ()

//@property (nonatomic, retain) UIViewController *gesturesVC;
//@property (nonatomic, retain) UIViewController *actionsVC;

@property BOOL goToActionsVc;
@property BOOL goToGesturesVC;

@end

@implementation NZConfigurationNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    //UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //self.gesturesVC = [storyboard instantiateViewControllerWithIdentifier:@"MainGesturesConfigurationVc"];
    //self.actionsVC = [storyboard instantiateViewControllerWithIdentifier:@"MainActionsConfigurationVc"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)switchFromGesturesToActions
{
    self.goToActionsVc = true;
   /* if ([self.presentedViewController isKindOfClass:[NZMainConfigurationVC class]]) {
        NZMainConfigurationVC *vc = (NZMainConfigurationVC *)self.presentedViewController;
        [vc.actionsButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    }*/
}

- (void)switchFromActionsToGestures
{
    self.goToGesturesVC = true;
    /*UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    [self popToRootViewControllerAnimated:YES];
    [self pushViewController:[storyboard instantiateViewControllerWithIdentifier:@"MainGesturesConfigurationVc"] animated:YES];
*/
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UI Navigator Controller Delegate
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([viewController isKindOfClass:[NZMainConfigurationVC class]]) {
        NZMainConfigurationVC *vc = (NZMainConfigurationVC *)viewController;
        if (self.goToActionsVc) {
            self.goToActionsVc = false;
            self.goToGesturesVC = false;
            [vc.actionsButton sendActionsForControlEvents:UIControlEventTouchUpInside];
        } else if (self.goToGesturesVC) {
            self.goToActionsVc = false;
            self.goToGesturesVC = false;
            [vc.gesturesButton sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
    }
}

@end
