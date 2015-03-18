//
//  BSDataItem.m
//  BaiSi
//
//  Created by tjs on 13-9-8.
//  Copyright (c) 2013年 tjs. All rights reserved.
//

#import "BSImageItem.h"
#import "BSSettings.h"
#import "BSPathManager.h"

@implementation BSImageItem
@synthesize width;
@synthesize height;
@synthesize image0URL;
@synthesize image1URL;
@synthesize image2URL;
@synthesize text;
@synthesize weixinURL;
@synthesize is_gif;
@synthesize image;
@synthesize gifFistFrameURL;
@synthesize showImageURL;

- (void)dealloc
{
    [image0URL release];
    [image1URL release];
    [image2URL release];
    [weixinURL release];
    [text release];
    [image release];
    [gifFistFrameURL release];
    [showImageURL release];
    [super dealloc];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        
        self.width = [aDecoder decodeIntegerForKey:@"width"];
        self.height = [aDecoder decodeIntegerForKey:@"height"];
        self.image0URL = [aDecoder decodeObjectForKey:@"image0URL"];
        self.image1URL = [aDecoder decodeObjectForKey:@"image1URL"];
        self.image2URL = [aDecoder decodeObjectForKey:@"image2URL"];
        self.weixinURL = [aDecoder decodeObjectForKey:@"weixinURL"];
        self.text = [aDecoder decodeObjectForKey:@"text"];
        self.gifFistFrameURL = [aDecoder decodeObjectForKey:@"gifFistFrameURL"];
        self.is_gif = [aDecoder decodeBoolForKey:@"is_gif"];
        self.showImageURL = [aDecoder decodeObjectForKey:@"showImageURL"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInteger:self.width forKey:@"width"];
    [aCoder encodeInteger:self.height forKey:@"height"];
    [aCoder encodeObject:self.image0URL forKey:@"image0URL"];
    [aCoder encodeObject:self.image1URL forKey:@"image1URL"];
    [aCoder encodeObject:self.image2URL forKey:@"image2URL"];
    [aCoder encodeObject:self.weixinURL forKey:@"weixinURL"];
    [aCoder encodeObject:self.text forKey:@"text"];
    [aCoder encodeObject:self.gifFistFrameURL forKey:@"gifFistFrameURL"];
    [aCoder encodeBool:self.is_gif forKey:@"is_gif"];
    [aCoder encodeObject:self.showImageURL forKey:@"showImageURL"];
}

- (void)updateDataFromDictionary:(NSDictionary *)dictionary
{
    id value = [dictionary objectForKey:@"width"];
    if ([value isKindOfClass:[NSString class]]) {
        self.width = [value intValue];
    }
    
    value = [dictionary objectForKey:@"height"];
    if ([value isKindOfClass:[NSString class]]) {
        self.height = [value intValue];
    }
    
    value = [dictionary objectForKey:@"image0"];
    if ([value isKindOfClass:[NSString class]]) {
        self.image0URL = [NSURL URLWithString:value];
    }
    
    value = [dictionary objectForKey:@"image1"];
    if ([value isKindOfClass:[NSString class]]) {
        self.image1URL = [NSURL URLWithString:value];
    }
    
    value = [dictionary objectForKey:@"image2"];
    if ([value isKindOfClass:[NSString class]]) {
        self.image2URL = [NSURL URLWithString:value];
    }
    
    value = [dictionary objectForKey:@"weixin_url"];
    if ([value isKindOfClass:[NSString class]]) {
        self.weixinURL = [NSURL URLWithString:value];
    }
    
    value = [dictionary objectForKey:@"text"];
    if ([value isKindOfClass:[NSString class]]) {
        self.text = value;
    }
    
    value = [dictionary objectForKey:@"is_gif"];
    if ([value isKindOfClass:[NSString class]]) {
        self.is_gif = [value boolValue];
    }
    
    if (self.is_gif) {
        value = [dictionary objectForKey:@"gifFistFrame"];
        if ([value isKindOfClass:[NSString class]]) {
            self.gifFistFrameURL = [NSURL URLWithString:value];
            self.showImageURL = self.gifFistFrameURL;
        }
    }
    else {
        self.showImageURL = self.image0URL;
    }
    
    UIImage  *tempImage = [UIImage imageWithContentsOfFile:[BSPathManager imageCacheForURL:self.showImageURL]];
    if (tempImage) {
        self.image = tempImage;
    }
    
    CGSize size = [[BSSettings sharedInstance] sizeForItemSize:CGSizeMake(self.width, self.height)];
    
    self.width = size.width;
    self.height = size.height;
    
}

@end
