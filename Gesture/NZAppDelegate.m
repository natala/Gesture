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
#import "NZWiFiPlugAction+CoreData.h"
#import "NZActionComposite+CoreData.h"
#import "NZAction+CoreData.h"
#import "NZLocation+CoreData.h"
#import "NZStartScreenVC.h"

@implementation NZAppDelegate

//@synthesize managedObjectContext = _managedObjectContext;
//@synthesize managedObjectModel = _managedObjectModel;
//@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    UIStoryboard *mainStorryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UISplitViewController *splitViewController = (UISplitViewController *)[mainStorryBoard instantiateViewControllerWithIdentifier:@"SplitViewController"];
    // NSLog(@"... %f",[splitViewController primaryColumnWidth]);
    //[splitViewController setPreferredPrimaryColumnWidthFraction:0.0666f];
    UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
    splitViewController.delegate = (id)navigationController.topViewController;
    
    // init the BLE connection
    [NZArduinoCommunicationManager sharedManager];
    
    // init the pipeline
    [NZPipelineController sharedManager];
    
    // hardcode the actions and action groups
    // controll the lights
    
    //*******************
    // Define Actions
    //*******************
    bool tumSl = true;
    bool tumCr = true;
    bool sapientStudio = true;
    [NZAction destroyAll];
    [NZLocation destroyAll];
    
    if (sapientStudio) {
        NZHttpRequest *hueOff01 = [NZHttpRequest create];
        hueOff01.name = @"hue 1 off";
        hueOff01.url = @"http://10.130.108.79/api/newdeveloper/lights/1/state";
        hueOff01.httpMethod = @"PUT";
        hueOff01.message = @"{\"on\":false}";
        hueOff01.httpHeaderContentType = @"application/json";
        hueOff01.httpHeaderAccept = @"application/json";
        hueOff01.undoCommand = @"{\"on\":true}";
        
        NZHttpRequest *hueOff02 = [NZHttpRequest create];
        hueOff02.name = @"hue 2 off";
        hueOff02.url = @"http://10.130.108.79/api/newdeveloper/lights/2/state";
        hueOff02.httpMethod = @"PUT";
        hueOff02.message = @"{\"on\":false}";
        hueOff02.httpHeaderContentType = @"application/json";
        hueOff02.httpHeaderAccept = @"application/json";
        hueOff02.undoCommand = @"{\"on\":true}";
        
        NZHttpRequest *hueOff03 = [NZHttpRequest create];
        hueOff03.name = @"hue 3 off";
        hueOff03.url = @"http://http://10.130.108.79/api/newdeveloper/lights/3/state";
        hueOff03.httpMethod = @"PUT";
        hueOff03.message = @"{\"on\":false}";
        hueOff03.httpHeaderContentType = @"application/json";
        hueOff03.httpHeaderAccept = @"application/json";
        hueOff03.undoCommand = @"{\"on\":true}";
        
        NZHttpRequest *hueOn01 = [NZHttpRequest create];
        hueOn01.name = @"hue 1 on";
        hueOn01.url = @"http://10.130.108.79/api/newdeveloper/lights/1/state";
        hueOn01.httpMethod = @"PUT";
        hueOn01.message = @"{\"on\":true}";
        hueOn01.httpHeaderContentType = @"application/json";
        hueOn01.httpHeaderAccept = @"application/json";
        hueOn01.undoCommand = @"{\"on\":false}";
        
        NZHttpRequest *hueOn02 = [NZHttpRequest create];
        hueOn02.name = @"hue 2 on";
        hueOn02.url = @"http://10.130.108.79/api/newdeveloper/lights/2/state";
        hueOn02.httpMethod = @"PUT";
        hueOn02.message = @"{\"on\":true}";
        hueOn02.httpHeaderContentType = @"application/json";
        hueOn02.httpHeaderAccept = @"application/json";
        hueOn02.undoCommand = @"{\"on\":false}";
        
        NZHttpRequest *hueOn03 = [NZHttpRequest create];
        hueOn03.name = @"hue 3 on";
        hueOn03.url = @"http://10.130.108.79/api/newdeveloper/lights/3/state";
        hueOn03.httpMethod = @"PUT";
        hueOn03.message = @"{\"on\":true}";
        hueOn03.httpHeaderContentType = @"application/json";
        hueOn03.httpHeaderAccept = @"application/json";
        hueOn03.undoCommand = @"{\"on\":false}";
        
        // herbi radio
        
        NZUrlSession *play = [NZUrlSession create];
        play.name = @"Music play";
        play.url = @"http://10.130.108.114/music/mpd/mpdcontrol.php?action=Play";
        play.undoCommand = @"http://10.130.108.114/music/mpd/mpdcontrol.php?action=Pause";
        
        NZUrlSession *pause = [NZUrlSession create];
        pause.name = @"Music pause";
        pause.url = @"http://10.130.108.114/music/mpd/mpdcontrol.php?action=Pause";
        pause.undoCommand = @"http://10.130.108.114/music/mpd/mpdcontrol.php?action=Play";
        
        NZUrlSession *next = [NZUrlSession create];
        next.name = @"Next song";
        next.url = @"http://10.130.108.114/music/mpd/mpdcontrol.php?action=Next";
        // no undo possibility
        
        NZUrlSession *volumeDown = [NZUrlSession create];
        volumeDown.name = @"Volume donw";
        volumeDown.url = @"http://10.130.108.114/music/mpd/mpdcontrol.php?action=VolumeDown";
        volumeDown.undoCommand = @"http://10.130.108.114/music/mpd/mpdcontrol.php?action=VolumeUp";
        
        NZUrlSession *volumeUp = [NZUrlSession create];
        volumeUp.name = @"Volume up";
        volumeUp.url = @"http://10.130.108.114/music/mpd/mpdcontrol.php?action=VolumeUp";
        volumeUp.undoCommand = @"http://10.130.108.114/music/mpd/mpdcontrol.php?action=VolumeDown";
        
        
        // wifi plug
       /* NZWiFiPlugAction *wifiPlug = [NZWiFiPlugAction create];
        wifiPlug.name = @"TV on";
        wifiPlug.hostName = @"ec2-54-217-214-117.eu-west-1.compute.amazonaws.com";
        wifiPlug.portNumber = [NSNumber numberWithInt:227];
        wifiPlug.plugId = @"0000250905C248";
        wifiPlug.plugName = @"nat";
        wifiPlug.username = @"nzarawska@sapient.com";
        wifiPlug.password = @"3048";
        wifiPlug.command = @"on";
        wifiPlug.undoCommand = @"off";
        
        NZWiFiPlugAction *wifiPlug2 = [NZWiFiPlugAction create];
        wifiPlug2.name = @"TV off";
        wifiPlug2.hostName = @"ec2-54-217-214-117.eu-west-1.compute.amazonaws.com";
        wifiPlug2.portNumber = [NSNumber numberWithInt:227];
        wifiPlug2.plugId = @"0000250905C248";
        wifiPlug2.plugName = @"nat";
        wifiPlug2.username = @"nzarawska@sapient.com";
        wifiPlug2.password = @"3048";
        wifiPlug2.command = @"off";
        wifiPlug2.undoCommand = @"on";
        */
        
        NZLocation *sapientStudio = [NZLocation create];
        sapientStudio.name = @"Sapient Studio Room";
        sapientStudio.uuid = @"a uuid 03";
        NSSet *sapientStudioActions = [[NSSet alloc] initWithArray:@[hueOff01, hueOff02, hueOff03, hueOn01, hueOn02, hueOn03]];
        sapientStudio.action = sapientStudioActions;
        
        NZLocation *sapientMusic = [NZLocation create];
        sapientMusic.name = @"Sapient Sound Studio";
        sapientMusic.uuid = @"a uuid 03";
        NSSet *sapientMusicActions = [[NSSet alloc] initWithArray:@[volumeDown, volumeUp, next, pause, play]];
        sapientMusic.action = sapientMusicActions;
        
        // composites
        /* NZActionComposite *morning = [NZActionComposite create];
         morning.name = @"Morning";
         morning.childActions = [[NSSet alloc] initWithObjects:hueOn01, hueOff02, hueOff03, nil];
         
         NZActionComposite *afternoonr = [NZActionComposite create];
         afternoonr.name = @"Afternoon";
         afternoonr.childActions = [[NSSet alloc] initWithObjects:hueOn01, hueOff02, hueOn03, nil];
         
         NZActionComposite *evening = [NZActionComposite create];
         evening.name = @"Evening";
         evening.childActions = [[NSSet alloc] initWithObjects:hueOn01, hueOn02, hueOn03, nil];
         */
        
    }
    
    // *********** //
    // TUM ACTIONS //
    // *********** //
    
    
    // SMART LAB //
    if (tumSl) {
        // lights
        NZHttpRequest *labLighWindowOn = [NZHttpRequest create];
        labLighWindowOn.name = @"LAB light window on";
        labLighWindowOn.url = @"http://ios14cmu-bruegge.in.tum.de:8080/rest/items/EO_SL_Light_B";
        labLighWindowOn.httpMethod = @"POST";
        labLighWindowOn.message = @"ON";
        labLighWindowOn.httpHeaderContentType = @"text/plain";
        
        NZHttpRequest *labLighWindowOff = [NZHttpRequest create];
        labLighWindowOff.name = @"LAB light window off";
        labLighWindowOff.url = @"http://ios14cmu-bruegge.in.tum.de:8080/rest/items/EO_SL_Light_B";
        labLighWindowOff.httpMethod = @"POST";
        labLighWindowOff.message = @"OFF";
        labLighWindowOff.httpHeaderContentType = @"text/plain";
        
        NZHttpRequest *labLighDoorOn = [NZHttpRequest create];
        labLighDoorOn.name = @"LAB light door on";
        labLighDoorOn.url = @"http://ios14cmu-bruegge.in.tum.de:8080/rest/items/EO_SL_Light_A";
        labLighDoorOn.httpMethod = @"POST";
        labLighDoorOn.message = @"ON";
        labLighDoorOn.httpHeaderContentType = @"text/plain";
        
        NZHttpRequest *labLighDoorOff = [NZHttpRequest create];
        labLighDoorOff.name = @"LAB light door off";
        labLighDoorOff.url = @"http://ios14cmu-bruegge.in.tum.de:8080/rest/items/EO_SL_Light_A";
        labLighDoorOff.httpMethod = @"POST";
        labLighDoorOff.message = @"OFF";
        labLighDoorOff.httpHeaderContentType = @"text/plain";
        
        //blinds
        NZHttpRequest *labBlindsOn = [NZHttpRequest create];
        labBlindsOn.name = @"LAB blinds on";
        labBlindsOn.url = @"http://ios14cmu-bruegge.in.tum.de:8080/rest/items/EO_SL_Blinds_B";
        labBlindsOn.httpMethod = @"POST";
        labBlindsOn.message = @"ON";
        labBlindsOn.httpHeaderContentType = @"text/plain";
        
        NZHttpRequest *labBlindsOff = [NZHttpRequest create];
        labBlindsOff.name = @"LAB blinds off";
        labBlindsOff.url = @"http://ios14cmu-bruegge.in.tum.de:8080/rest/items/EO_SL_Blinds_B";
        labBlindsOff.httpMethod = @"POST";
        labBlindsOff.message = @"OFF";
        labBlindsOff.httpHeaderContentType = @"text/plain";
        
        NZLocation *smartLab = [NZLocation create];
        smartLab.name = @"TUM Smart Lab";
        smartLab.uuid = @"a uuid";
        NSSet *slActions = [[NSSet alloc] initWithArray:@[labBlindsOff, labBlindsOn, labLighDoorOff, labLighDoorOn, labLighWindowOff, labLighWindowOn]];
        smartLab.action = slActions;
    }
    // CONFERENCE ROOM //
    if (tumCr) {
        //blinds
        NZHttpRequest *crBlindsBOn = [NZHttpRequest create];
        crBlindsBOn.name = @"CR blinds B on";
        crBlindsBOn.url = @"http://ios14cmu-bruegge.in.tum.de:8080/rest/items/EO_CR_Blinds_B";
        crBlindsBOn.httpMethod = @"POST";
        crBlindsBOn.message = @"ON";
        crBlindsBOn.httpHeaderContentType = @"text/plain";
        
        NZHttpRequest *crBlindsBOff = [NZHttpRequest create];
        crBlindsBOff.name = @"CR blinds B off";
        crBlindsBOff.url = @"http://ios14cmu-bruegge.in.tum.de:8080/rest/items/EO_CR_Blinds_B";
        crBlindsBOff.httpMethod = @"POST";
        crBlindsBOff.message = @"OFF";
        crBlindsBOff.httpHeaderContentType = @"text/plain";
        
        //lights
        NZHttpRequest *crLightsAOn = [NZHttpRequest create];
        crLightsAOn.name = @"CR lights door on";
        crLightsAOn.url = @"http://ios14cmu-bruegge.in.tum.de:8080/rest/items/EO_CR_Light_A";
        crLightsAOn.httpMethod = @"POST";
        crLightsAOn.message = @"ON";
        crLightsAOn.httpHeaderContentType = @"text/plain";
        
        NZHttpRequest *crLightsAOff = [NZHttpRequest create];
        crLightsAOff.name = @"CR lights door off";
        crLightsAOff.url = @"http://ios14cmu-bruegge.in.tum.de:8080/rest/items/EO_CR_Light_A";
        crLightsAOff.httpMethod = @"POST";
        crLightsAOff.message = @"OFF";
        crLightsAOff.httpHeaderContentType = @"text/plain";
        
        NZHttpRequest *crLightsBOn = [NZHttpRequest create];
        crLightsBOn.name = @"CR lights window on";
        crLightsBOn.url = @"http://ios14cmu-bruegge.in.tum.de:8080/rest/items/EO_CR_Light_B";
        crLightsBOn.httpMethod = @"POST";
        crLightsBOn.message = @"ON";
        crLightsBOn.httpHeaderContentType = @"text/plain";
        
        NZHttpRequest *crLightsBOff = [NZHttpRequest create];
        crLightsBOff.name = @"CR lights window off";
        crLightsBOff.url = @"http://ios14cmu-bruegge.in.tum.de:8080/rest/items/EO_CR_Light_B";
        crLightsBOff.httpMethod = @"POST";
        crLightsBOff.message = @"OFF";
        crLightsBOff.httpHeaderContentType = @"text/plain";
        
        /*
         //composits
         NZActionComposite *crlightsOn = [NZActionComposite create];
         crlightsOn.name = @"CR Lights On";
         crlightsOn.childActions = [[NSSet alloc] initWithObjects:crLightsAOn, crLightsBOn, nil];
         
         NZActionComposite *crlightsOff = [NZActionComposite create];
         crlightsOff.name = @"CR Lights Off";
         crlightsOff.childActions = [[NSSet alloc] initWithObjects:crLightsAOff, crLightsBOff, nil];
         
         */
        NZLocation *conferenceRoom = [NZLocation create];
        conferenceRoom.name = @"TUM Conference Room";
        conferenceRoom.uuid = @"a uuid 02";
        NSSet *crActions = [[NSSet alloc] initWithArray:@[crBlindsBOff, crBlindsBOn, crLightsAOff, crLightsAOn, crLightsBOff, crLightsBOn]];
        conferenceRoom.action = crActions;
    }
    
    [[NZCoreDataManager sharedManager] save];
    
    
    // Load the Start Screen VC
    
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
