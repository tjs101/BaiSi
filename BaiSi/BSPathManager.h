//
//  BSPathManager.h
//  BaiSi
//
//  Created by quentin on 13-9-9.
//  Copyright (c) 2013年 tjs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSPathManager : NSObject

//imageCache
+ (NSString *)imageCacheForURL:(NSURL *)url;

//data.dst
+ (NSString *)dataPathForTime;

+ (NSArray *)arrayFormDatapath;

//获取历史具体路径
+ (NSString *)pathForHistoryFileName:(NSString *)filename;

+ (BOOL)existFileForURL:(NSURL *)url;

//删除全部图片缓存
+ (BOOL)clearAllImageCache;
//删除全部下载历史
+ (BOOL)clearAllLocalHistory;

+ (BOOL)deleteFileForPath:(NSString *)path;

//分类保存加载数据
+ (NSString *)pathForUpdateData;
@end
