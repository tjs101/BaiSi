//
//  BSHttpRequestConnect.m
//  BaiSi
//
//  Created by quentin on 13-9-9.
//  Copyright (c) 2013年 tjs. All rights reserved.
//

#import "BSHttpRequestConnect.h"

@interface BSHttpRequestConnect ()

{
    int           _totalLength;
}

@property   (nonatomic, retain)  NSURL   *url;
@property   (nonatomic, retain)  NSURLConnection  *requestConnection;
@property   (nonatomic, retain)  NSMutableData   *requestData;
@end

@implementation BSHttpRequestConnect
@synthesize url;
@synthesize requestConnection;
@synthesize infoDictionary;
@synthesize requestData;
@synthesize delegate;

- (void)dealloc
{
    delegate = nil;
    self.url = nil;
    self.requestConnection = nil;
    self.infoDictionary = nil;
    self.requestData = nil;
    
    [super dealloc];
}

- (id)initWithURL:(NSURL *)aURL
{
    if (self = [super init]) {
        self.url = aURL;
    }
    return self;
}

+ (id)requestWithURL:(NSURL *)aURL
{
    return [[[self alloc] initWithURL:aURL] autorelease];
}

- (void)clearDelegateAndCancel
{
    delegate = nil;
    [self.requestConnection cancel];
    self.requestConnection = nil;
}

- (void)startAsynchronous
{
    NSURLRequest  *request = [NSURLRequest requestWithURL:self.url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
    
    NSURLConnection  *connection = [[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease];
    self.requestConnection = connection;
    
    if (connection == nil) {
        
    }
    [connection start];
}

#pragma mark - connection delegate
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (delegate && [delegate respondsToSelector:@selector(BSHttpRequestConnect:fail:)]) {
        [delegate BSHttpRequestConnect:self fail:error];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.requestData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    int totalLength = self.requestData.length;
    
    if (_totalLength == totalLength) {//数据完全下载
        
        if (delegate && [delegate respondsToSelector:@selector(BSHttpRequestConnect:data:)]) {
            [delegate BSHttpRequestConnect:self data:self.requestData];
        }
        
    } else {
        
        NSError  *error = [NSError errorWithDomain:@"totalLength is equal Content-Length" code:1 userInfo:nil];
        if (delegate && [delegate respondsToSelector:@selector(BSHttpRequestConnect:fail:)]) {
            [delegate BSHttpRequestConnect:self fail:error];
        }
    }
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse  *httpResponse = (NSHTTPURLResponse *)response;
    NSDictionary *info = httpResponse.allHeaderFields;
    
    self.requestData = [NSMutableData data];
    _totalLength = [[info objectForKey:@"Content-Length"] intValue];
    
//    Log(@"info %@",info);
}

@end
