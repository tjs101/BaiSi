//
//  BSImageCell.h
//  BaiSi
//
//  Created by tjs on 13-9-8.
//  Copyright (c) 2013年 tjs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSImageItem.h"
@class BSImageCell;

@protocol BSImageCellDelegate <NSObject>

- (void)onClickBSImageCell:(BSImageCell *)cell;

@end


@interface BSImageCell : UITableViewCell

@property   (nonatomic, retain) BSImageItem  *items;
@property   (nonatomic, retain)  UIImageView  *imageView;
@property   (nonatomic, assign) id<BSImageCellDelegate>  delegate;


+ (CGFloat)heightForItem:(BSImageItem *)item;

@end
