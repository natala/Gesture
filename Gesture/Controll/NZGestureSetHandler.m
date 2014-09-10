//
//  NZGestureSetHandler.m
//  Gesture
//
//  Created by Natalia Zarawska on 9/10/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZGestureSetHandler.h"

@implementation NZGestureSetHandler


#pragma mark - Singleton

+ (NZGestureSetHandler *)sharedManager
{
    static NZGestureSetHandler *sharedManager = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedManager = [NZGestureSetHandler new];
    });
    
    return sharedManager;
}

- (id)init
{
    self = [super init];
    if (self) {
 
        /*NSString *path = [[NZPipelineController documentPath] stringByAppendingPathComponent:kGrtPipelineFileName];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
            NSLog(@"Pipeline Controller is creating a new file for saving");
            if (![[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil]) {
                NSLog(@"Couldn't create file");
            }
         */
    }
    return self;
}

- (void)loadGestureSetWithName:(NSString *)gestureSetName
{
    if (gestureSetName) {
        self.selectedGestureSet = [NZGestureSet findWithName:gestureSetName];
    }
    
    if (!self.selectedGestureSet) {
        NSLog(@"gesture set with name: %@ not found! Creating a new set", gestureSetName);
    }
}

@end
