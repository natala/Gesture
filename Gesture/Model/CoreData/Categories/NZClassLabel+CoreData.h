//
//  NZSensorDataSet+CoreData.h
//  Gesture
//
//  Created by Natalia Zarawska on 7/1/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZClassLabel.h"

@interface NZClassLabel (CoreData)


+ (NZClassLabel *)create;

+ (NSArray *)findAll;

+ (NZClassLabel *)findLates;

/**
 * @note the index of the class label maches the indices of the classes in the training set of the classifier / pipeline
 * @param index the index of the class label we want to find
 * @return the class label with the given index
 */
+ (NZClassLabel *)findEntitiesWithIndex:(NSNumber *)index;

- (void)destroy;

+ (void)destroyAll;

@end
