//
//  NZUrlSession+Execute.m
//  Gesture
//
//  Created by Natalia Zarawska on 8/25/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZUrlSession+Execute.h"

@implementation NZUrlSession (Execute)

- (void)execute
{
    NSLog(@"NZUrlSession - execute()");
    [self executeWithCommand:self.url];
}

- (void)undo
{
    [self executeWithCommand:self.undoCommand];
}

- (void)executeWithCommand:(NSString *)command
{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:command] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {NSLog(@"url session command send");
        [dataTask cancel];
        
    }];
    [dataTask resume];
}

@end
