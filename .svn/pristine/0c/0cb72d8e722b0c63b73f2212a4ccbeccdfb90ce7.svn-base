//
//  BSSettings.h
//  BaiSi
//
//  Created by tjs on 13-9-8.
//  Copyright (c) 2013年 tjs. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BSSettings : NSObject

@property   (nonatomic, retain)  NSDictionary   *currentItem;
@property   (nonatomic, retain)  NSString       *currentServer;

@property   (nonatomic, assign)  BOOL           enableWifi;
@property   (nonatomic, assign)  BOOL           enable3G;

@property   (nonatomic, assign)  BOOL           onlyWifDownload;

@property   (nonatomic, assign)  int            currentMaxCountForItemKey;//根据itemkey设置获取总数
@property   (nonatomic, assign)  int            currentPageForItemKey;//根据itemkey设置获取起始页数
@property   (nonatomic, assign) float           currentPointYForItemKey;//根据itemkey设置获取偏移值

@property   (nonatomic, assign) BOOL            showInsertScreenAd;//是否显示插屏广告

+ (BSSettings *)sharedInstance;

- (CGSize)sizeForItemSize:(CGSize)size;

//加载本地plist文件，获取NSArray数组
- (NSArray *)loadDataWithPlistName:(NSString *)plistName;

- (void)startNetStatusNotification;


@end
