//
//  BSPathManager.m
//  BaiSi
//
//  Created by quentin on 13-9-9.
//  Copyright (c) 2013年 tjs. All rights reserved.
//

#import "BSPathManager.h"
#import "NSString+Util.h"
#import "BSSystem.h"

#define  kImageCacheDir   @"ImageCacheData"
#define  kSaveDataDir     @"SaveData"
#define  kUpdateDataDir   @"Data"
#define  kUpdateDataName  @"Data.dst"

@implementation BSPathManager


+ (NSString *)imageCacheDir
{
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    
    path = [path stringByAppendingPathComponent:kImageCacheDir];
    
    NSFileManager  *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:path]) {
        [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return path;
}

+ (NSString *)imageCacheForURL:(NSURL *)url
{
    NSString  *fileName = [url.absoluteString hashString];
    
    NSString *path = [self imageCacheDir];
    
    return [path stringByAppendingPathComponent:fileName];
}

+ (BOOL)existFileForURL:(NSURL *)url
{
    BOOL  flag = [[NSFileManager defaultManager] fileExistsAtPath:[self imageCacheForURL:url]];
    return flag;
}

+ (NSString *)pathForDataDir
{
    
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    
    path = [path stringByAppendingPathComponent:kSaveDataDir];
    
    NSFileManager  *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:path]) {
        [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return path;
    
}

+ (NSString *)dataPathForTime
{
    NSDateFormatter  *formatter = [BSSystem formatter];
    
    NSString  *fileName = [formatter stringFromDate:[NSDate date]];
    return [[self pathForDataDir] stringByAppendingPathComponent:fileName];
}

+ (NSArray *)arrayFormDatapath
{
    NSArray  *array = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self pathForDataDir] error:nil];
    return array;
}

+ (NSString *)pathForHistoryFileName:(NSString *)filename
{
    return [[self pathForDataDir] stringByAppendingPathComponent:filename];
}

#pragma mark - clear

+ (BOOL)clearAllImageCache
{
    return [self deleteFileForPath:[self imageCacheDir]];
}

+ (BOOL)clearAllLocalHistory
{
    return [self deleteFileForPath:[self pathForDataDir]];
}

+ (BOOL)deleteFileForPath:(NSString *)path
{
    NSFileManager *manager = [NSFileManager defaultManager];
    return [manager removeItemAtPath:path error:nil];
}

#pragma mark - 保存最新加载的数据

+ (NSString *)pathForUpdateData
{
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    
    path = [path stringByAppendingPathComponent:kUpdateDataDir];
    
    NSFileManager  *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:path]) {
        [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return [path stringByAppendingPathComponent:kUpdateDataName];
}

@end
