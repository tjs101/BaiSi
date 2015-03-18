//
//  BSConfig.h
//  BaiSi
//
//  Created by tjs on 13-9-7.
//  Copyright (c) 2013年 tjs. All rights reserved.
//

#ifndef BaiSi_BSConfig_h
#define BaiSi_BSConfig_h

#import "BSScrollLabel.h"

#define SET_SCROLL_NAVIGATION_TITLE_WITH_LIMIT_WIDTH(title, limit)  \
do {\
if ([self.navigationItem.titleView isKindOfClass:[BSScrollLabel class]]) {\
BSScrollLabel *label = (BSScrollLabel *) self.navigationItem.titleView;\
label.text = title;\
}\
else {\
CGRect rect = CGRectMake(0, 0, limit, 40); \
BSScrollLabel *label = [[BSScrollLabel alloc] initWithFrame:rect duration:8.0 andFadeLength:10.0f];\
label.backgroundColor = [UIColor clearColor]; \
label.textColor = [UIColor blackColor];\
label.font = [UIFont boldSystemFontOfSize:16];\
label.text = title;\
self.navigationItem.titleView = label;\
[label release];\
}\
} while(0)

#define SET_SCROLL_NAVIGATION_TITLE(title)  SET_SCROLL_NAVIGATION_TITLE_WITH_LIMIT_WIDTH(title, 180)


#define ADD_BACK_BUTTON(actionMethod)    do {\
UIButton *left_btn = [UIButton buttonWithType:UIButtonTypeCustom]; \
[left_btn setImage:[UIImage imageNamed:@"button_back_navigation_n"] forState:UIControlStateNormal]; \
[left_btn setImage:[UIImage imageNamed:@"button_back_navigation_h"] forState:UIControlStateHighlighted]; \
[left_btn sizeToFit]; \
[left_btn addTarget:self action:@selector(actionMethod) forControlEvents:UIControlEventTouchUpInside]; \
UIBarButtonItem *left_item = [[[UIBarButtonItem alloc] initWithCustomView:left_btn] autorelease]; \
self.navigationItem.leftBarButtonItem = left_item; \
} while (0)

#define ADD_NAVIGATION_RIGHT_BUTTON(actionMethod,title)    do {\
UIButton *right_btn = [UIButton buttonWithType:UIButtonTypeCustom]; \
[right_btn setBackgroundImage:[UIImage imageNamed:@"button_gray_n"] forState:UIControlStateNormal]; \
[right_btn setBackgroundImage:[UIImage imageNamed:@"button_gray_h"] forState:UIControlStateHighlighted]; \
[right_btn setTitle:title forState:UIControlStateNormal];\
[right_btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];\
[right_btn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];\
right_btn.titleLabel.font = [UIFont systemFontOfSize:14];\
[right_btn sizeToFit]; \
[right_btn addTarget:self action:@selector(actionMethod) forControlEvents:UIControlEventTouchUpInside]; \
UIBarButtonItem *right_item = [[[UIBarButtonItem alloc] initWithCustomView:right_btn] autorelease]; \
self.navigationItem.rightBarButtonItem = right_item; \
} while (0)

//navigation

#define  SET_NAVIGATION_BAR_MAKE_LARGE(view)  do { \
                                                 view.frame = CGRectMake(0, 0, 64, 44); \
                                                }while(0)

#define kDefaultImageWidth 280

#define kPageSize  10
#define kFirstPage 1

//plist
#define kSettingsPlistName  @"Settings"
#define kItemKey   @"itemKey"
#define kItemName  @"itemName"
#define kItemHeader  @"itemHeader"
#define kItemId   @"itemId" // 只有56视频使用

#define kCategoryImage  @"图片"
#define kCategoryVideo  @"视频"

#define kAdmobKey   @"a1527ce555e0369"
//umeng
#define kUmengAppKey  @"5231c93e56240b7a620e9ac6"

//多盟
#define kDomobPublisherID  @"56OJzcIIuNMYUdMQZ5"
#define kDomobInline   @"16TLmnAoApOzANUGuue5aAez"
#define kDomobOpenScreen  @"16TLmnAoApOzANUGux5Ul5ek"
#define kDomobInsertScreen @"16TLmnAoApOzANUGusLH7Inz"



#define  kLastUpdate  @"http://api.budejie.com/api/api_open.php?c=data&a=list&version=1.4&from=ipad&type=10&comment=0&maxid=0&client=iPad&market=&appID=535047933&appName=baisibudejie_hd&version=1.5&device=iPad%203%20Mini&jailbroken=1"

#define  kHotShare  @"http://api.budejie.com/api/api_open.php?c=data&a=list&version=1.4&from=ipad&type=10&order=repost&time=week&maxid=0&client=iPad&market=&appID=535047933&appName=baisibudejie_hd&version=1.5&device=iPad%203%20Mini&userID=&userSex=&jailbroken=1"

#define  kHotComment  @"http://api.budejie.com/api/api_open.php?c=data&a=list&version=1.4&from=ipad&type=10&order=comment&time=week&maxid=0&client=iPad&market=&appID=535047933&appName=baisibudejie_hd&version=1.5&device=iPad%203%20Mini&userID=&userSex=&jailbroken=1"

#define  kFavourite  @"http://api.budejie.com/api/api_open.php?c=data&a=list&version=1.4&from=ipad&type=10&order=favourite&time=week&maxid=0&client=iPad&market=&appID=535047933&appName=baisibudejie_hd&version=1.5&device=iPad%203%20Mini&userID=&userSex=&jailbroken=1"

#define  kGifImage  @"http://api.budejie.com/api/api_open.php?c=data&a=list&version=1.4&from=ipad&type=10&comment=0&maxid=0&tag=GIF%E5%9B%BE&client=iPad&market=&appID=535047933&appName=baisibudejie_hd&version=1.5&device=iPad%203%20Mini&userID=&userSex=&jailbroken=1"


extern NSString  *kEnableWifiNotification;
extern NSString  *kEnable3GNotification;
extern NSString  *kUnEnableNetNotification;


extern NSString  *kNeedRefreshNotification;

//改变item总数时通知
extern NSString  *kChangePageCountNotification;

//56视频
#define  k56AppKey       @"3000002820"
#define  k56AppSecret    @"731db366fcac1cf2"

#endif
