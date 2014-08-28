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
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:self.url] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"play music request send");
        [dataTask cancel];
        
    }];
    [dataTask resume];
}

@end
