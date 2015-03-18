//
//  BSMainViewController.h
//  BaiSi
//
//  Created by tjs on 13-9-8.
//  Copyright (c) 2013年 tjs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSRequestConnect.h"
#import "BSImageCell.h"
#import "BSImageLoader.h"
#import "EGORefreshTableHeaderView.h"
#import "BSBaseTableViewController.h"

@interface BSMainViewController : BSBaseTableViewController <BSRequestConnectDelegate, BSImageLoaderDelegate, EGORefreshTableHeaderDelegate, BSImageCellDelegate, UIActionSheetDelegate>

- (void)changeCategory;
- (void)choosePage;
@end
