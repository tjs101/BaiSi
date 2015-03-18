//
//  BSImageLoader.h
//  BaiSi
//
//  Created by quentin on 13-9-9.
//  Copyright (c) 2013年 tjs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSHttpRequestConnect.h"
@class BSImageLoader;

@protocol BSImageLoaderDelegate <NSObject>

- (void)BSImageLoader:(BSImageLoader *)imageLoader error:(NSError *)error info:(NSDictionary *)info;
- (void)BSImageLoader:(BSImageLoader *)imageLoader image:(UIImage *)image info:(NSDictionary *)info;
- (void)BSImageLoader:(BSImageLoader *)imageLoader existImage:(UIImage *)image info:(NSDictionary *)info;

@end

@interface BSImageLoader : NSObject<BSHttpRequestConnectDelegate>

@property   (nonatomic, assign) id<BSImageLoaderDelegate> delegate;

- (void)clearCacheDelegate;
- (void)loadImageWithURL:(NSURL *)aUrl info:(NSDictionary *)info;

@end
