//
//  NZCoreDataManager.m
//  Gesture
//
//  Created by Natalia Zarawska on 6/30/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZCoreDataManager.h"

@interface NZCoreDataManager ()

@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation NZCoreDataManager

#pragma mark - Singleton

+ (NZCoreDataManager *)sharedManager
{
    static NZCoreDataManager *sharedManager = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedManager = [NZCoreDataManager new];
    });
    
    return sharedManager;
}

#pragma mark - Setup

- (id)init
{
    if ([super init]) {
    }
    return self;
}

#pragma mark - Save

- (void)save
{
    NSError *error = nil;
    
    if (self.managedObjectContext != nil) {
        if ([self.managedObjectContext hasChanges]) {
            [self.managedObjectContext processPendingChanges];
        }
        
        if ([self.managedObjectContext hasChanges] && ![self.managedObjectContext save:&error]) {
            NSLog(@"\n\n\n======================================================================\n");
            NSLog(@" [SAVING MANAGED OBJECT CONTEXT WENT WRONG]");
            NSLog(@"Unresolved error %@, %@ \n\n\n", error, [error userInfo]);
            NSLog(@"\n======================================================================\n\n\n");
        }
    }
}

- (void)discardChanges
{
    [self.managedObjectContext rollback];
}

#pragma mark - Core Data Stack

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


// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory]
                       URLByAppendingPathComponent:@"Gesture.sqlite"];
    
    NSDictionary *options = @{ NSMigratePersistentStoresAutomaticallyOption : @YES,
                               NSInferMappingModelAutomaticallyOption : @YES };
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                   configuration:nil
                                                             URL:storeURL
                                                         options:options
                                                           error:&error])
    {
        /*
         * Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         * Check the error message to determine what the actual problem was.
         *
         *
         * If the persistent store is not accessible, there is typically something wrong with the file
         * path. Often, a file URL is pointing into the application's resources directory instead of a
         * writeable directory.
         *
         * If you encounter schema incompatibility errors during development, you can reduce their
         * frequency by:
         * Simply deleting the existing store:
         * [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         *
         * Performing automatic lightweight migration by passing the following dictionary as the
         * options parameter:
         * @{NSMigratePersistentStoresAutomaticallyOption:@YES,
         * NSInferMappingModelAutomaticallyOption:@YES}
         *
         * Lightweight migration will only work for a limited set of schema changes; consult
         * "Core Data Model Versioning and Data Migration Programming Guide" for details.
         *
         */
        NSLog(@"\n\n\n======================================================================\n");
        NSLog(@"PLEASE REPORT TO @NATALIA ZARAWSKA! [DB MIGRATION WENT WRONG]");
        NSLog(@"Unresolved error %@, %@ \n\n\n", error, [error userInfo]);
        NSLog(@"\n======================================================================\n\n\n");
        
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
        return self.persistentStoreCoordinator;
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Helper

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                   inDomains:NSUserDomainMask] lastObject];
}


@end
