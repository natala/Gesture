//
//  NZAppDelegate.m
//  Gesture
//
//  Created by Natalia Zarawska on 6/26/14.
//  Copyright (c) 2014 TUM. All rights reserved.//

#import "NZAppDelegate.h"
#import "NZArduinoCommunicationManager.h"
#import "Model/CoreData/NZCoreDataManager.h"
#import "NZMasterMenuTVC.h"
#import "NZPipelineController.h"
#import "NZCoreDataManager.h"

#import "NZHttpRequest+CoreData.h"
#import "NZUrlSession+CoreData.h"
#import "NZActionComposite+CoreData.h"

@implementation NZAppDelegate

//@synthesize managedObjectContext = _managedObjectContext;
//@synthesize managedObjectModel = _managedObjectModel;
//@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
    splitViewController.delegate = (id)navigationController.topViewController;

    // init the BLE connection
    [NZArduinoCommunicationManager sharedManager];
    
    // init the pipeline
    [NZPipelineController sharedManager];
    
    // hardcode the actions and action groups
    // controll the lights
  /*  [NZHttpRequest destroyAll];
    [NZActionComposite destroyAll];
    
    NZHttpRequest *hueOff01 = [NZHttpRequest create];
    hueOff01.name = @"hue 1 off";
    hueOff01.url = @"http://10.130.108.79/api/newdeveloper/lights/1/state";
    hueOff01.httpMethod = @"PUT";
    hueOff01.message = @"{\"on\":false}";
    
    NZHttpRequest *hueOff02 = [NZHttpRequest create];
    hueOff02.name = @"hue 2 off";
    hueOff02.url = @"http://10.130.108.79/api/newdeveloper/lights/2/state";
    hueOff02.httpMethod = @"PUT";
    hueOff02.message = @"{\"on\":false}";
    
    NZHttpRequest *hueOff03 = [NZHttpRequest create];
    hueOff03.name = @"hue 3 off";
    hueOff03.url = @"http://10.130.108.79/api/newdeveloper/lights/3/state";
    hueOff03.httpMethod = @"PUT";
    hueOff03.message = @"{\"on\":false}";
    
    NZHttpRequest *hueOn01 = [NZHttpRequest create];
    hueOn01.name = @"hue 1 on";
    hueOn01.url = @"http://10.130.108.79/api/newdeveloper/lights/2/state";
    hueOn01.httpMethod = @"PUT";
    hueOn01.message = @"{\"on\":true}";
    
    NZHttpRequest *hueOn02 = [NZHttpRequest create];
    hueOn02.name = @"hue 2 on";
    hueOn02.url = @"http://10.130.108.79/api/newdeveloper/lights/2/state";
    hueOn02.httpMethod = @"PUT";
    hueOn02.message = @"{\"on\":true}";
    
    NZHttpRequest *hueOn03 = [NZHttpRequest create];
    hueOn03.name = @"hue 3 on";
    hueOn03.url = @"http://10.130.108.79/api/newdeveloper/lights/3/state";
    hueOn03.httpMethod = @"PUT";
    hueOn03.message = @"{\"on\":true}";
    
    // coposites
    NZActionComposite *morning = [NZActionComposite create];
    morning.name = @"Morning";
    morning.childActions = [[NSSet alloc] initWithObjects:hueOn01, hueOff02, hueOff03, nil];
    
    NZActionComposite *afternoonr = [NZActionComposite create];
    afternoonr.name = @"Afternoon";
    afternoonr.childActions = [[NSSet alloc] initWithObjects:hueOn01, hueOff02, hueOn03, nil];
    
    NZActionComposite *evening = [NZActionComposite create];
    evening.name = @"Evening";
    evening.childActions = [[NSSet alloc] initWithObjects:hueOn01, hueOn02, hueOn03, nil];
*/
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [[NZCoreDataManager sharedManager] save];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
  //  [self saveContext];
    [[NZCoreDataManager sharedManager] save];
}
/*
- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}
*/
#pragma mark - Core Data stack
/*
// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Gesture" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}
*/
/*
// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Gesture.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
 */

@end
