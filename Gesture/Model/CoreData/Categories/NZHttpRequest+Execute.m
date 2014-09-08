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
    if (self.httpHeaderContentType) {
            [request setValue:self.httpHeaderContentType forHTTPHeaderField:@"Content-Type"];
    }
    if (self.httpHeaderAccept) {
        [request setValue:self.httpHeaderAccept forHTTPHeaderField:@"Accept"];
    }
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    //[request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:requestData];
    NSURLConnection *connectin = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (connectin) {
        NSLog(@"did setup connection");
    }
}

#pragma mark - URLConnectionDelegate 
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"connectio failed with error: %@", error);
}

@end
