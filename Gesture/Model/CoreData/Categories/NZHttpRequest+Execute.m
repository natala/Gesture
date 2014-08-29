//
//  NZHttpRequest+Execute.m
//  Gesture
//
//  Created by Natalia Zarawska on 8/25/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZHttpRequest+Execute.h"

@implementation NZHttpRequest (Execute)

- (void)execute
{
    NSLog(@"NZHttpRequest - execute()");
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]];
    NSData *requestData = [self.message dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPMethod:self.httpMethod];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:requestData];
    NSURLConnection *connectin = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (connectin) {
        NSLog(@"did setup connection");
    }
}

@end
