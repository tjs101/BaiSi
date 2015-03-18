//
//  BSSystem.h
//  BaiSi
//
//  Created by quentin on 13-9-12.
//  Copyright (c) 2013年 tjs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTStatusBarOverlay.h"

@interface BSSystem : NSObject


//判断是否有网络环境
+ (BOOL)isEnableInternetConnection;

+ (NSDateFormatter *)formatter;

//umeng
+ (void)startUmengTrack;
+ (void)trackBeginView:(NSString *)trackView;
+ (void)trackEndView:(NSString *)trackView;

//show statusbar overlay

+ (void)showStatusBarFinishMessage:(NSString *)message;
+ (void)showStatusBarLoading;
+ (void)hideStatusBar;

@end
