//
//  BSImageLoader.m
//  BaiSi
//
//  Created by quentin on 13-9-9.
//  Copyright (c) 2013年 tjs. All rights reserved.
//

#import "BSImageLoader.h"
#import "BSPathManager.h"
#import "BSSettings.h"
#import "BSSystem.h"

@interface BSImageLoader ()

@property   (nonatomic, retain)  NSMutableArray  *requestsArray;
@end

@implementation BSImageLoader
@synthesize requestsArray;
@synthesize delegate;

- (void)dealloc
{
    self.requestsArray = nil;
    [super dealloc];
}

- (id)init
{
    if (self = [super init]) {
        self.requestsArray = [NSMutableArray array];
    }
    return self;
}

- (void)clearCacheDelegate
{
    for (BSHttpRequestConnect *request in self.requestsArray) {
        [request clearDelegateAndCancel];
        request = nil;
    }
    
    delegate = nil;
}

- (void)loadImageWithURL:(NSURL *)aUrl info:(NSDictionary *)info
{
    BOOL exist = [BSPathManager existFileForURL:aUrl];
    
    if (exist) {
        
        UIImage  *image = [UIImage imageWithContentsOfFile:[BSPathManager imageCacheForURL:aUrl]];
        if (delegate && [delegate respondsToSelector:@selector(BSImageLoader:existImage:info:)]) {
            [delegate BSImageLoader:self existImage:image info:info];
        }
    }
    else {
        
        BOOL  enable = NO;
        
        if ([BSSettings sharedInstance].onlyWifDownload && [BSSettings sharedInstance].enableWifi) {
            enable = YES;
        } else if (![BSSettings sharedInstance].onlyWifDownload && [BSSystem isEnableInternetConnection]) {
            enable = YES;
        }
        
        if (enable) {
            
            BSHttpRequestConnect  *request = [BSHttpRequestConnect requestWithURL:aUrl];
            request.delegate = self;
            
            if (info) {
                NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:aUrl, @"url", info, @"info", nil];
                request.infoDictionary = dict;
            }
            else {
                NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:aUrl, @"url", nil];
                request.infoDictionary = dict;
            }
            
            [self.requestsArray addObject:request];
            
            [request startAsynchronous];
            
        }
    }
}

- (void)BSHttpRequestConnect:(BSHttpRequestConnect *)request fail:(NSError *)error
{
    NSDictionary  *info = [request.infoDictionary objectForKey:@"info"];
    
    if (delegate && [delegate respondsToSelector:@selector(BSImageLoader:error:info:)]) {
        [delegate BSImageLoader:self error:error info:info];
    }
}

- (void)BSHttpRequestConnect:(BSHttpRequestConnect *)request data:(NSData *)data
{
    NSURL  *imageUrl = [request.infoDictionary objectForKey:@"url"];
    NSDictionary  *info = [request.infoDictionary objectForKey:@"info"];

    UIImage  *image = [UIImage imageWithData:data];
    if (image.size.width > 0 && image.size.height > 0) {
        if (delegate && [delegate respondsToSelector:@selector(BSImageLoader:image:info:)]) {
            
            [data writeToFile:[BSPathManager imageCacheForURL:imageUrl] atomically:YES];
//            Log(@"url %@",[BSPathManager imageCacheForURL:imageUrl]);
            [delegate BSImageLoader:self image:image info:info];
        }
    }
    else {
        if (delegate && [delegate respondsToSelector:@selector(BSImageLoader:error:info:)]) {

            [delegate BSImageLoader:self error:nil info:info];
        }
    }
}

@end
