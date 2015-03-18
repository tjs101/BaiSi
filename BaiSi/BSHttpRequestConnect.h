//
//  BSHttpRequestConnect.h
//  BaiSi
//
//  Created by quentin on 13-9-9.
//  Copyright (c) 2013年 tjs. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BSHttpRequestConnect;

@protocol BSHttpRequestConnectDelegate <NSObject>

- (void)BSHttpRequestConnect:(BSHttpRequestConnect *)request data:(NSData *)data;
- (void)BSHttpRequestConnect:(BSHttpRequestConnect *)request fail:(NSError *)error;

@end

@interface BSHttpRequestConnect : NSObject<NSURLConnectionDataDelegate, NSURLConnectionDelegate>

@property   (nonatomic, retain)  NSDictionary  *infoDictionary;
@property   (nonatomic, assign) id<BSHttpRequestConnectDelegate>  delegate;

+ (id)requestWithURL:(NSURL *)aURL;
- (void)startAsynchronous;
- (void)clearDelegateAndCancel;
@end
