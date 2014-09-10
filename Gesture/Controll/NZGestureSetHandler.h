//
//  NZGestureSetHandler.h
//  Gesture
//
//  Created by Natalia Zarawska on 9/10/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NZGestureSet+CoreData.h"

@interface NZGestureSetHandler : NSObject

@property (nonatomic, strong) NZGestureSet *selectedGestureSet;


/**
 * Creates and returns the singleton instance of the Gesture Set Controller.
 * @author  Natalia Zarawska
 * @return  The singleton instance of the Gesture Set Controller.
 */

+ (NZGestureSetHandler *)sharedManager;


/**
 * loads the gesture set with the given name and the appropriate pipeline
 * @param gestureSetName the name of the gesture set to be loaded
 */
- (void)loadGestureSetWithName:(NSString *)gestureSetName;

@end
