//
//  NSManagedObject+CoreData.h
//  KneeHapp
//
//  Created by Pascal Fritzen on 05.05.14.
//  Copyright (c) 2014 Praxis. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "NZCoreDataManager.h"

@interface NSManagedObject (CoreData)

/**
 * Creates and returns an entity with a given name in the KHCoreDataManger's shared managedObjectContext.
 * @note    To persist the insertion, call the KHCoreDataManager's @c-(void)save afterwards.
 * @author  Pascal Fritzen
 * @param   name   The name of the entity to create.
 * @return  The created entity.
 */
+ (NSManagedObject *)createEntityWithName:(NSString *)name;

/**
 * Finds and returns all entities with a given name in the database.
 * @author  Pascal Fritzen
 * @param   name   The name of the entities to find.
 * @return  An array containing all found entities.
 */
+ (NSArray *)findAllEntitiesWithName:(NSString *)name;

/**
 * Deletes ALL(!) entities with a given name from the database.
 * @note    To persist the deletion, call the KHCoreDataManager's @c-(void)save afterwards.
 * @author  Pascal Fritzen
 */
+ (void)destroyAllEntitiesWithName:(NSString *)name;

/**
 * Deletes the current entity from the database.
 * @note    To persist the deletion, call the KHCoreDataManager's @c-(void)save afterwards.
 * @author  Pascal Fritzen
 */
- (void)destroy;


/**
 * Clones and returns a deep copy of the entity.
 * @author  Pascal Fritzen
 * @return  A clone of the entity.
 */
- (NSManagedObject *)clone;

@end
