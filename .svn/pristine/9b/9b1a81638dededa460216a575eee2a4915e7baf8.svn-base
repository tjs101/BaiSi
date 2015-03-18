//
//  XMZoomScrollView.m
//  ting
//
//  Created by quentin on 13-6-3.
//
//

#import "BSZoomScrollView.h"
#import "BSPathManager.h"
#import <ImageIO/ImageIO.h>
#import "MBProgressHUD.h"
#import "BSSystem.h"

#define kMaxScale 3.0f

@interface BSZoomScrollView ()
{
    UIImageView     *_imageView;
    CGFloat         _defaultScale;
    
    CGFloat         _duration;
    
    UIButton        *_downloadButton;
    CGFloat         _offY;
}

@end

@implementation BSZoomScrollView
@synthesize item;

- (void)dealloc
{
    [item release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.delegate = self;
        
        [self customInit];
    }
    return self;
}

- (void)customInit
{
    
    UIImageView *image_View = [[[UIImageView alloc] init] autorelease];
    image_View.userInteractionEnabled = YES;
    [self addSubview:image_View];
    _imageView = image_View;
    
    UITapGestureRecognizer  *recognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeFromSuperview)] autorelease];
    [image_View addGestureRecognizer:recognizer];
    
    UIButton  *downloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    downloadButton.enabled = NO;
    [downloadButton setImage:[UIImage imageNamed:@"btn_save"] forState:UIControlStateNormal];
    [downloadButton addTarget:self action:@selector(downloadImageAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:downloadButton];
    _downloadButton = downloadButton;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    [_downloadButton sizeToFit];
    
    CGFloat x = self.frame.size.width - _downloadButton.frame.size.width;
    CGFloat y = self.frame.size.height - _downloadButton.frame.size.height + _offY;
    
    _downloadButton.frame = CGRectMake(x, y, _downloadButton.frame.size.width, _downloadButton.frame.size.height);
}

- (void)removeFromSuperview
{
    [self reset];
    [super removeFromSuperview];
}

- (void)reset
{
    [_imageView stopAnimating];
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    self.contentOffset = CGPointMake(0, 0);
}

- (void)setItem:(BSImageItem *)aItem
{
    if (item != aItem) {
        [item release];
        item = [aItem retain];
    }
    
    [self refreshUI];
    
    if (item.height > self.frame.size.height) {
        
        _imageView.frame = CGRectMake((self.frame.size.width - item.width)/2, 0, item.width, item.height);
    }
    else {
        _imageView.frame = CGRectMake((self.frame.size.width - item.width)/2, (self.frame.size.height - item.height)/2, item.width, item.height);
    }
    self.contentSize = CGSizeMake(item.width, item.height);
}

- (void)refreshUI
{
    _imageView.image = item.image;
    
    if (item.is_gif && [BSPathManager existFileForURL:item.image0URL]) {//类型为gif并存在缓存
        
        [MBProgressHUD hideAllHUDsForView:self animated:NO];
        
        _downloadButton.enabled = YES;
        
        NSArray  *array = [self gifInfo:item];
        
        _imageView.animationImages = array;
        _imageView.animationDuration = _duration * [array count];
        [_imageView startAnimating];
        
    } else if (item.is_gif && ![BSPathManager existFileForURL:item.image0URL]) {//类型为gif并且不存在缓存
        
        _downloadButton.enabled = NO;
        if ([BSSystem isEnableInternetConnection]) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
            hud.labelText = NSLocalizedString(@"GIF图片加载中,请稍后", nil);
        }
        else {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
            hud.labelText = NSLocalizedString(@"无网络，不能加载数据", nil);
            [hud hide:YES afterDelay:2];
        }
    }
    else {
        _downloadButton.enabled = YES;
    }
}

- (NSArray *)gifInfo:(BSImageItem *)aItem
{

    NSString  *path = [BSPathManager imageCacheForURL:aItem.image0URL];

    NSData *data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:path]];

    CGImageSourceRef source = CGImageSourceCreateWithData((CFDataRef)data, NULL);
    size_t count = CGImageSourceGetCount(source);

    NSMutableArray  *array = [NSMutableArray array];
    for (size_t i = 0; i < count; i++)
    {
        CGImageRef gcImage = CGImageSourceCreateImageAtIndex(source, i, NULL);
        UIImage *image = [UIImage imageWithCGImage:gcImage scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
        NSDictionary* frameProperties = [(NSDictionary *)CGImageSourceCopyPropertiesAtIndex(source, i, NULL) autorelease];
        _duration = [[[frameProperties objectForKey:(NSString*)kCGImagePropertyGIFDictionary] objectForKey:(NSString*)kCGImagePropertyGIFDelayTime] doubleValue];
        _duration = MAX(_duration, 0.01);
        [array addObject:image];
        CGImageRelease(gcImage);
    }
    CFRelease(source);
    return array;
}

#pragma mark - download image
- (void)downloadImageAction:(id)sender
{

    dispatch_queue_t queue = dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, NULL);
    
    dispatch_async(queue,^{
        
        UIImage  *image = nil;
        
        if (item.is_gif) {
            NSString  *path = [BSPathManager imageCacheForURL:item.image0URL];
            
            NSData *data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:path]];
            
            image = [UIImage imageWithData:data];
        }
        else {
            NSString  *path = [BSPathManager imageCacheForURL:item.showImageURL];
            
            NSData *data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:path]];
            
            image = [UIImage imageWithData:data];
        }
        
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        
    });
    dispatch_release(queue);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error == nil) {
        
        MBProgressHUD *progress = [MBProgressHUD showHUDAddedTo:self animated:YES];
        progress.mode = MBProgressHUDModeText;
        progress.labelText = NSLocalizedString(@"图片保存成功!",nil);
        [progress hide:YES afterDelay:2];
    }
    else {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"如果想保存图片，请进入设置->隐私->图片中授权" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"我知道了！", nil];
        [alertView show];
        [alertView release];
        
    }
    
}

#pragma mark - scrollview delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    _offY = scrollView.contentOffset.y;
    
}

@end
