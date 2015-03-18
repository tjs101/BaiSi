//
//  BSImageCell.m
//  BaiSi
//
//  Created by tjs on 13-9-8.
//  Copyright (c) 2013年 tjs. All rights reserved.
//

#import "BSImageCell.h"
#import "BSSettings.h"
#import <ImageIO/ImageIO.h>
#import "BSPathManager.h"

#define kImageWidth  300
#define kImageHeight 300

@interface BSImageCell ()

{
    UIImageView   *_imageView;
    UILabel       *_infoLabel;
    
    CGFloat       _duration;
    
    
    UIImageView   *_bgImageView;
}

@end

@implementation BSImageCell
@synthesize items;
@synthesize imageView = _imageView;
@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self customInit];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)customInit
{

    UILabel  *label = [[[UILabel alloc] init] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:13];
    [self addSubview:label];
    _infoLabel = label;
    
    UIImage  *image = [[UIImage imageNamed:@"image_frame"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    
    UIImageView *bgImageView = [[[UIImageView alloc] init] autorelease];
    bgImageView.image = image;
    bgImageView.userInteractionEnabled = YES;
    [self addSubview:bgImageView];
    _bgImageView = bgImageView;
    
    UIImageView  *imageView = [[[UIImageView alloc] init] autorelease];
    imageView.userInteractionEnabled = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [bgImageView addSubview:imageView];
    _imageView = imageView;
    
    UITapGestureRecognizer  *recognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickImageView:)] autorelease];
    [imageView addGestureRecognizer:recognizer];
}

- (void)onClickImageView:(id)sender
{
    if (delegate && [delegate respondsToSelector:@selector(onClickBSImageCell:)] && _imageView.image != nil) {
        [delegate onClickBSImageCell:self];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_infoLabel sizeToFit];
    [_imageView sizeToFit];
    [_bgImageView sizeToFit];
    
    CGFloat  x = (self.frame.size.width - kImageWidth)/2, y = 8;
    
    CGSize size1 = [items.text sizeWithFont:_infoLabel.font constrainedToSize:CGSizeMake(kImageWidth, MAXFLOAT)];
    
    _infoLabel.frame = CGRectMake(x, y, kImageWidth, size1.height);
    
    y = _infoLabel.frame.origin.y + _infoLabel.frame.size.height + 8;
    
    CGSize  size = CGSizeMake(items.width, items.height);
    x = (self.frame.size.width - size.width)/2;
    
    CGFloat cap = 3;
    
    _imageView.frame = CGRectMake(cap, cap, size.width, size.height);
    _bgImageView.frame = CGRectMake(x, y, size.width + cap *2, size.height + cap * 2);
}

- (void)setItems:(BSImageItem *)aItem
{
    if (items != aItem) {
        [items release];
        items = [aItem retain];
    }
    _infoLabel.text = items.text;
    [self setNeedsLayout];
}

+ (CGFloat)heightForItem:(BSImageItem *)item
{
    
    CGFloat  height = item.height;
    
    CGSize size = [item.text sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(kImageWidth, MAXFLOAT)];
 
    return height + size.height + 40;
    
}

@end
