//
//  NZGesture.m
//  Gesture
//
//  Created by Natalia Zarawska on 7/16/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZGesture.h"

@implementation NZGesture

#pragma mark - attributes
@dynamic timeStampCreated;
@dynamic timeStampUpdated;
@dynamic httpRequestMessageBody;
@dynamic httpRequestUrl;

#pragma mark - relationships
@dynamic gestureSet;
@dynamic label;
@dynamic negativeSamples;
@dynamic positiveSamples;

@end
