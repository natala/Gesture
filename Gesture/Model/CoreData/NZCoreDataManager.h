//
//  NZCoreDataManager.h
//  Gesture
//
//  Created by Natalia Zarawska on 6/30/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NZCoreDataManager : NSObject


/**
 * Creates and returns the singleton instance of the core data manager.
 * @author  Pascal Fritzen
 * @return  The singleton instance of the core data manager.
 */
+ (NZCoreDataManager *)sharedManager;


/**
 * The managed object context of the core data manager.
 * @note    This managed object context is shared amongst all CoreData-related classes and only those
 * classes (except NSFetchedResultsController) should access it therefore.
 * @author  Pascal Fritzen
 */
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;


/**
 * Saves all changes (e.g. insertions, updates, deletions) of all core data objects since the last
 * time this method was called or since the manager was instantiated.
 * @author  Pascal Fritzen
 */
- (void)save;


/**
 * Discards all changes (e.g. insertions, updates, deletions) of all core data objects since the last
 * time the method @p-(void)save was called.
 * @author  Pascal Fritzen
 */
- (void)discardChanges;

@end

