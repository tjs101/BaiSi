//
//  BSAppDelegate.h
//  BaiSi
//
//  Created by tjs on 13-9-7.
//  Copyright (c) 2013年 tjs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSMainViewController;
@class BSSettingsViewController;
@class BSDownloadListTableViewController;

@interface BSAppDelegate : UIResponder <UIApplicationDelegate>

@property (retain, nonatomic) UIWindow *window;
@property (nonatomic, retain) BSMainViewController *viewCtrl;
@property (nonatomic, retain) BSSettingsViewController *settingsViewCtrl;
@property (nonatomic, retain) BSDownloadListTableViewController *downloadViewCtrl;
@end
