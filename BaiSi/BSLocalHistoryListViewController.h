//
//  BSLocalHistoryListViewController.h
//  BaiSi
//
//  Created by tjs on 13-9-11.
//  Copyright (c) 2013年 tjs. All rights reserved.
//

#import "BSBaseTableViewController.h"
#import "BSImageCell.h"
#import "BSImageLoader.h"

@interface BSLocalHistoryListViewController : BSBaseTableViewController <BSImageCellDelegate, BSImageLoaderDelegate, UIAlertViewDelegate>

- (id)initWithArray:(NSArray *)array index:(int)index;

@end
