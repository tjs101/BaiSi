//
//  BSDataItem.h
//  BaiSi
//
//  Created by tjs on 13-9-8.
//  Copyright (c) 2013年 tjs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSImageItem : NSObject<NSCoding>


@property (nonatomic, assign) int    height;
@property (nonatomic, assign) int    width;
@property (nonatomic, retain) NSURL  *image0URL;
@property (nonatomic, retain) NSURL  *image1URL;
@property (nonatomic, retain) NSURL  *image2URL;
@property (nonatomic, retain) NSURL  *weixinURL;
@property (nonatomic, copy) NSString  *text;
@property (nonatomic, assign) BOOL   is_gif;
@property   (nonatomic, retain)  NSURL   *gifFistFrameURL;
@property   (nonatomic, retain)  NSURL   *showImageURL;

@property   (nonatomic, retain)  UIImage  *image;


- (void)updateDataFromDictionary:(NSDictionary *)dictionary;

@end
