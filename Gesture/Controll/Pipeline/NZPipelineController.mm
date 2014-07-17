//
//  NZPipelineController.m
//  Gesture
//
//  Created by Natalia Zarawska on 7/17/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZPipelineController.h"
#import <fstream>
#import <string>
#import <sstream>
#import <iostream>
#import "GRT.h"


NSString *const kGrtPipelineFileName = @"pipelineFile.txt";

@interface NZPipelineController ()

//@property GRT::GestureRecognitionPipeline *grtPipeline;

@end

@implementation NZPipelineController

GRT::GestureRecognitionPipeline grtPipeline;

#pragma mark - Singleton

+ (NZPipelineController *)sharedManager
{
    static NZPipelineController *sharedManager = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedManager = [NZPipelineController new];
    });
    
    return sharedManager;
}


- (id)init
{
    self = [super init];
    if (self) {
        grtPipeline = GRT::GestureRecognitionPipeline();
        NSString *path = [[NZPipelineController documentPath] stringByAppendingPathComponent:kGrtPipelineFileName];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
            if (![[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil]) {
                NSLog(@"Couldn't create file");
            }
        }
        
        if ( !grtPipeline.loadPipelineFromFile([path UTF8String]) ) {
            NSLog(@"Couldn't load pipeline from file. Set up a new one");
            // create a new pipeline and save
            grtPipeline.setClassifier( GRT::DTW() );
            if( !grtPipeline.savePipelineToFile([path UTF8String]) ) {
                NSLog(@"ADD THE pipelineFile.txt TO THE APP!!! ");
                abort();
            }
        }
    }
    return self;
}

#pragma mark - Helpers

+ (NSString *)documentPath
{
    NSArray *searchPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [searchPath objectAtIndex:0];
}


@end
