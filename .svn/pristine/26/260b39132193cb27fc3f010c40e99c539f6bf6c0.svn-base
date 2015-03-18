//
//  BSRequestConnect.m
//  BaiSi
//
//  Created by tjs on 13-9-8.
//  Copyright (c) 2013年 tjs. All rights reserved.
//

#import "BSRequestConnect.h"
#import "JSONKit.h"

@interface BSRequestConnect ()

{
    BSRequestCompleteBlock    _completeBlock;
    BSRequestFailBlock        _failBlock;
}

@property  (nonatomic, retain)  NSURL  *url;
@property  (nonatomic, retain)  NSURLConnection  *requestConnection;
@property  (nonatomic, retain)  NSMutableData  *requestData;
@end


@implementation BSRequestConnect
@synthesize url;
@synthesize requestConnection;
@synthesize requestData;
@synthesize delegate;
@synthesize requestDictionary;

- (void)dealloc
{
    self.requestConnection = nil;
    self.requestData = nil;
    self.url = nil;
    self.delegate = nil;
    self.requestDictionary = nil;
    
    [_completeBlock release];
    _completeBlock = nil;
    
    [_failBlock  release];
    _failBlock = nil;
    
    [super dealloc];
}


- (id)initWithURL:(NSURL *)aUrl
{
    if (self = [super init]) {
        self.url = aUrl;
    }
    return self;
}

+ (id)requestWithURL:(NSURL *)aURL
{
    return [[[self alloc] initWithURL:aURL] autorelease];
}


- (void)clearDelegateAndCancel
{
    [self.requestConnection cancel];
    self.requestConnection = nil;
    self.delegate = nil;
}

- (void)startAsynchronous
{
    NSURLRequest  *request = [NSURLRequest requestWithURL:self.url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    
    NSURLConnection  *connection = [[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease];
    [connection start];
    self.requestConnection = connection;
}

#pragma mark - block

- (void)setRequestComplete:(BSRequestCompleteBlock)block
{
    [_completeBlock release];
    _completeBlock = [block copy];
}

- (void)setRequestFail:(BSRequestFailBlock)block
{
    [_failBlock release];
    _failBlock = [block copy];
}

#pragma mark - connection delegate
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.requestData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    if (_failBlock) {
        _failBlock();
        
        [_failBlock release];
        _failBlock = nil;
    }
    
    self.requestData = nil;
    if (delegate && [delegate respondsToSelector:@selector(BSRequestConnect:fail:)]) {
        [delegate BSRequestConnect:self fail:error];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.requestData = [NSMutableData data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (requestData) {
        
        NSError  *error = nil;
        
        id  value = [requestData objectFromJSONDataWithParseOptions:JKParseOptionValidFlags error:&error];
        self.requestDictionary = [NSDictionary dictionaryWithDictionary:value];
        
        if (_completeBlock) {
            _completeBlock();
            [_completeBlock release];
            _completeBlock = nil;
        }
        
        if (error == nil && [value isKindOfClass:[NSDictionary class]]) {
            if (delegate && [delegate respondsToSelector:@selector(BSRequestConnect:)]) {

                [delegate BSRequestConnect:self];
            }
        }
        else {
            if (delegate && [delegate respondsToSelector:@selector(BSRequestConnect:fail:)]) {
                [delegate BSRequestConnect:self fail:error];
            }
        }
    }
}

@end
