//
//  BSSettings.m
//  BaiSi
//
//  Created by tjs on 13-9-8.
//  Copyright (c) 2013年 tjs. All rights reserved.
//

#import "BSSettings.h"
#import "Reachability.h"

NSString  *kEnableWifiNotification = @"enableWifiNotification";
NSString  *kEnable3GNotification = @"enable3GNotification";
NSString  *kUnEnableNetNotification = @"unEnableNetNotification";

#define   kShowInsertCount  10

@interface BSSettings ()

@property  (nonatomic, retain)  Reachability   *reachability;

@end

@implementation BSSettings
@synthesize currentItem;
@synthesize currentServer;
@synthesize reachability;
@synthesize enable3G;
@synthesize enableWifi;
@synthesize onlyWifDownload;
@synthesize currentMaxCountForItemKey;
@synthesize currentPageForItemKey;
@synthesize currentPointYForItemKey;
@synthesize showInsertScreenAd;

- (void)dealloc
{
    [currentItem release];
    [settings release];
    [currentServer release];
    [reachability release];
    [super dealloc];
}

static  BSSettings *settings = nil;

+ (BSSettings *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        settings = [[BSSettings alloc] init];
    });
    return settings;
}

- (CGSize)sizeForItemSize:(CGSize)size
{
    float width = size.width;
    float height = size.height;
    
    if (width >= kDefaultImageWidth) {
        float scale = width/kDefaultImageWidth;
        width = kDefaultImageWidth;
        height = height/scale;
    }
    return CGSizeMake(width, height);
}

- (NSArray *)loadDataWithPlistName:(NSString *)plistName
{
    NSBundle  *bundle = [NSBundle mainBundle];
    NSString  *path = [bundle pathForResource:plistName ofType:@"plist"];
    NSArray  *array = [NSArray arrayWithContentsOfFile:path];
    return array;
}

#pragma mark - currentItem
- (NSDictionary *)currentItem
{
    NSUserDefaults  *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary  *item = [defaults objectForKey:@"currentItem"];
    
    if (item == nil) {

        NSArray  *array = [[self loadDataWithPlistName:kSettingsPlistName] objectAtIndex:0];
        
        NSDictionary *dict = [array objectAtIndex:0];
        
        item = [NSDictionary dictionaryWithDictionary:dict];
    }
    return item;
    
}

- (void)setCurrentItem:(NSDictionary *)aCurrentItem
{
    NSUserDefaults  *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:aCurrentItem forKey:@"currentItem"];
    [defaults synchronize];
}

#pragma mark - currentServer

- (NSString *)currentServer
{
    NSString *server = nil;
    
    NSString *itemKey = [self.currentItem objectForKey:kItemKey];
    
    if ([itemKey isEqualToString:@"lastUpdate"]) {
        server = kLastUpdate;
    } else if ([itemKey isEqualToString:@"hotShare"]) {
        server = kHotShare;
    } else if ([itemKey isEqualToString:@"hotComment"]) {
        server = kHotComment;
    } else if ([itemKey isEqualToString:@"favourite"]) {
        server = kFavourite;
    } else if ([itemKey isEqualToString:@"gif"]) {
        server = kGifImage;
    }
    return server;
}

#pragma mark - reachability
- (void)startNetStatusNotification
{
    self.reachability = [Reachability reachabilityForInternetConnection];
    [self.reachability startNotifier];
    [self netStatusForReachability:reachability];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChange:) name:kReachabilityChangedNotification object:reachability];
}

- (void)reachabilityChange:(NSNotification *)notification
{
    Reachability  *aReachability = [notification object];
    [self netStatusForReachability:aReachability];
}

- (void)netStatusForReachability:(Reachability *)aReachability
{
    if (reachability == aReachability) {
        
        NetworkStatus  status = [reachability currentReachabilityStatus];
        
        switch (status) {
            case ReachableViaWiFi:
                self.enableWifi = YES;
                 [[NSNotificationCenter defaultCenter] postNotificationName:kEnableWifiNotification object:nil];
                break;
            case ReachableViaWWAN:
                self.enable3G = YES;
                 [[NSNotificationCenter defaultCenter] postNotificationName:kEnable3GNotification object:nil];
                break;
            case NotReachable:
            default:
                self.enable3G = NO;
                self.enableWifi = NO;
                 [[NSNotificationCenter defaultCenter] postNotificationName:kUnEnableNetNotification object:nil];
                break;
        }
        
    }
}

#pragma mark - onlyWifDownload

- (BOOL)onlyWifDownload
{
    NSUserDefaults  *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:@"onlyWifDownload"];
}

- (void)setOnlyWifDownload:(BOOL)aOnlyWifDownload
{
    NSUserDefaults  *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:aOnlyWifDownload forKey:@"onlyWifDownload"];
    [defaults synchronize];
}

#pragma mark - currentMaxCount itemkey

- (int)currentMaxCountForItemKey
{
    NSUserDefaults  *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *info = [defaults objectForKey:[[self currentItem] objectForKey:kItemKey]];
    return [[info objectForKey:@"currentMaxCountForItemKey"] intValue];
}

- (void)setCurrentMaxCountForItemKey:(int)aCurrentMaxCountForItemKey
{
    NSUserDefaults  *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:aCurrentMaxCountForItemKey], @"currentMaxCountForItemKey", [NSNumber numberWithInt:[self currentPageForItemKey]], @"currentPageForItemKey",[NSNumber numberWithFloat:[self currentPointYForItemKey]], @"currentPointYForItemKey", nil];
    
    [defaults setObject:info forKey:[[self currentItem] objectForKey:kItemKey]];
    [defaults synchronize];
}

#pragma mark - currentPage itemKey

- (int)currentPageForItemKey
{
    NSUserDefaults  *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *info = [defaults objectForKey:[[self currentItem] objectForKey:kItemKey]];
    return [[info objectForKey:@"currentPageForItemKey"] intValue] <=0 ? kFirstPage : [[info objectForKey:@"currentPageForItemKey"] intValue];
}

- (void)setCurrentPageForItemKey:(int)aCurrentPageForItemKey
{
    NSUserDefaults  *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:aCurrentPageForItemKey], @"currentPageForItemKey", [NSNumber numberWithInt:[self currentMaxCountForItemKey]], @"currentMaxCountForItemKey", [NSNumber numberWithFloat:[self currentPointYForItemKey]], @"currentPointYForItemKey",nil];
    [defaults setObject:info forKey:[[self currentItem] objectForKey:kItemKey]];
    [defaults synchronize];
}

#pragma mark - currentPointYForItemKey

- (CGFloat)currentPointYForItemKey
{
    NSUserDefaults  *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *info = [defaults objectForKey:[[self currentItem] objectForKey:kItemKey]];
    return [[info objectForKey:@"currentPointYForItemKey"] floatValue];
}

- (void)setCurrentPointYForItemKey:(CGFloat)aCurrentPointYForItemKey
{
    NSUserDefaults  *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:aCurrentPointYForItemKey], @"currentPointYForItemKey", [NSNumber numberWithInt:[self currentMaxCountForItemKey]], @"currentMaxCountForItemKey", [NSNumber numberWithInt:[self currentPageForItemKey]], @"currentPageForItemKey", nil];
    
    [defaults setObject:info forKey:[[self currentItem] objectForKey:kItemKey]];
    [defaults synchronize];
}

#pragma mark - 

- (BOOL)showInsertScreenAd
{
    NSUserDefaults  *defaults = [NSUserDefaults standardUserDefaults];
    
    int count = [[defaults objectForKey:@"showInsertScreenAdCount"] intValue];
    
    if (count >= kShowInsertCount) {
        [defaults setObject:[NSNumber numberWithInt:0] forKey:@"showInsertScreenAdCount"];
        return YES;
    } else {
        count = count + 1;
        
        [defaults setObject:[NSNumber numberWithInt:count] forKey:@"showInsertScreenAdCount"];
    }
    return NO;
}

@end
