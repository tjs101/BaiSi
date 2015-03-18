//
//  BSAppDelegate.m
//  BaiSi
//
//  Created by tjs on 13-9-7.
//  Copyright (c) 2013年 tjs. All rights reserved.
//

#import "BSAppDelegate.h"
#import "BSMainViewController.h"
#import "BSNavigationViewController.h"
#import "BSSettingsViewController.h"
#import "MMDrawerController.h"
#import "BSSettings.h"
#import "BSSystem.h"
#import "BSDownloadListTableViewController.h"


@implementation BSAppDelegate
@synthesize viewCtrl = _viewCtrl;
@synthesize window = _window;
@synthesize settingsViewCtrl = _settingsViewCtrl;
@synthesize downloadViewCtrl = _downloadViewCtrl;

- (void)dealloc
{
    [_window release];
    [_viewCtrl release];
    [_settingsViewCtrl release];
    [_downloadViewCtrl release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [UIApplication sharedApplication].statusBarHidden = NO;
    [BSSystem startUmengTrack];
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];

    self.viewCtrl = [[[BSMainViewController alloc] init] autorelease];
    
    self.settingsViewCtrl = [[[BSSettingsViewController alloc] init] autorelease];
    
    self.downloadViewCtrl = [[[BSDownloadListTableViewController alloc] init] autorelease];
    
    BSNavigationViewController  *navigationCtrl = [[[BSNavigationViewController alloc] initWithRootViewController:self.viewCtrl] autorelease];
    
    MMDrawerController  *mmCtrl = [[[MMDrawerController alloc] initWithCenterViewController:navigationCtrl leftDrawerViewController:self.settingsViewCtrl rightDrawerViewController:self.downloadViewCtrl] autorelease];
    [mmCtrl setMaximumLeftDrawerWidth:[UIScreen mainScreen].bounds.size.width/2];
    [mmCtrl setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [mmCtrl setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    
    self.window.rootViewController = mmCtrl;
    
    [self.window makeKeyAndVisible];
    
    [self setNotification];
    
    [[BSSettings sharedInstance] startNetStatusNotification];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - net notification

- (void)setNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enable3GNotification) name:kEnable3GNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enableWifiNotification) name:kEnableWifiNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(unEnableNetNotification) name:kUnEnableNetNotification object:nil];
}

- (void)enable3GNotification
{
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"您当前处于3G网络,浏览会消耗您的流量" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"我知道了", nil];
//    [alertView show];
//    [alertView release];
}

- (void)enableWifiNotification
{
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"您当前处于Wifi网络,可以下载帖子,在无网络的情况下不消耗流量阅读" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"我知道了", nil];
//    [alertView show];
//    [alertView release];
}

- (void)unEnableNetNotification
{
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"您当前处于无网络状况,可以去“下载历史”进行浏览" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"我知道了", nil];
//    [alertView show];
//    [alertView release];
}

@end
