//
//  BSRequestConnect.h
//  BaiSi
//
//  Created by tjs on 13-9-8.
//  Copyright (c) 2013年 tjs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^BSRequestCompleteBlock)(void);
typedef void(^BSRequestFailBlock)(void);

@class BSRequestConnect;

@protocol BSRequestConnectDelegate <NSObject>

- (void)BSRequestConnect:(BSRequestConnect *)request fail:(NSError *)error;
- (void)BSRequestConnect:(BSRequestConnect *)request;

@end

@interface BSRequestConnect : NSObject<NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (nonatomic, assign) id<BSRequestConnectDelegate>  delegate;
@property (nonatomic, retain) NSDictionary   *requestDictionary;

- (void)setRequestComplete:(BSRequestCompleteBlock)block;
- (void)setRequestFail:(BSRequestFailBlock)block;

- (void)clearDelegateAndCancel;

+ (id)requestWithURL:(NSURL *)aURL;
- (void)startAsynchronous;

@end
