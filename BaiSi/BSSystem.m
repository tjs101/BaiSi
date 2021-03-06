//
//  BSSystem.m
//  BaiSi
//
//  Created by quentin on 13-9-12.
//  Copyright (c) 2013年 tjs. All rights reserved.
//

#import "BSSystem.h"
#import "Reachability.h"

@implementation BSSystem

- (void)dealloc
{
    [shareInstance release];
    [super dealloc];
}

+ (BOOL)isEnableInternetConnection
{
    return ([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable) && ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable);
}

static NSDateFormatter *shareInstance = nil;

+ (NSDateFormatter *)formatter
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[NSDateFormatter alloc] init];
        shareInstance.dateFormat = @"yyyy年MM月dd日-HH:mm:ss";
    });
    return shareInstance;
}

#pragma mark - umeng

+ (void)startUmengTrack
{
//    [MobClick startWithAppkey:kUmengAppKey reportPolicy:REALTIME channelId:nil];
}

+ (void)trackBeginView:(NSString *)trackView
{
//    [MobClick beginLogPageView:trackView];
}

+ (void)trackEndView:(NSString *)trackView
{
//    [MobClick endLogPageView:trackView];
}

#pragma mark - statusbar overlay

+ (void)showStatusBarFinishMessage:(NSString *)message
{
    MTStatusBarOverlay  *statusBar = [MTStatusBarOverlay sharedInstance];
    statusBar.animation = MTStatusBarOverlayAnimationShrink;
    [statusBar postFinishMessage:message duration:2 animated:YES];
}

+ (void)showStatusBarLoading
{
    MTStatusBarOverlay  *statusBar = [MTStatusBarOverlay sharedInstance];
    [statusBar postMessage:@"Loading..."];
}

+ (void)hideStatusBar
{
    MTStatusBarOverlay  *statusBar = [MTStatusBarOverlay sharedInstance];
    [statusBar hide];
}

@end
