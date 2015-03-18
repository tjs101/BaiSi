//
//  BSLocalHistoryListViewController.m
//  BaiSi
//
//  Created by tjs on 13-9-11.
//  Copyright (c) 2013年 tjs. All rights reserved.
//

#import "BSLocalHistoryListViewController.h"
#import "BSImageItem.h"
#import "BSPathManager.h"
#import "BSZoomScrollView.h"
#import "BSSystem.h"
#import "BSSettings.h"

#define kAlert3GChangeWifTag  101

@interface BSLocalHistoryListViewController ()

{
    BOOL    _needRefresh;
}

@property  (nonatomic, retain)  NSArray  *filenamesArray;
@property  (nonatomic, assign)  int    dataIndex;
@property  (nonatomic, retain)  NSArray  *itemsArray;
@property  (nonatomic, retain)  BSZoomScrollView  *showImageView;
@property  (nonatomic, retain)  BSImageLoader  *imageLoader;


@end

@implementation BSLocalHistoryListViewController
@synthesize filenamesArray;
@synthesize dataIndex;
@synthesize itemsArray;
@synthesize showImageView;
@synthesize imageLoader;

- (void)dealloc
{
    [filenamesArray release];
    [itemsArray release];
    self.showImageView = nil;
    
    [imageLoader clearCacheDelegate];
    self.imageLoader = nil;

    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithArray:(NSArray *)array index:(int)index
{
    if (self = [super init]) {
        self.filenamesArray = array;
        self.dataIndex = index;
        
        SET_SCROLL_NAVIGATION_TITLE([array objectAtIndex:index]);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIButton  *refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [refreshButton setImage:[UIImage imageNamed:@"button_refresh_n"] forState:UIControlStateNormal];
    [refreshButton setImage:[UIImage imageNamed:@"button_refresh_h"] forState:UIControlStateHighlighted];
    [refreshButton sizeToFit];
    SET_NAVIGATION_BAR_MAKE_LARGE(refreshButton);
    [refreshButton addTarget:self action:@selector(refreshImage:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem  *rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:refreshButton] autorelease];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    ADD_BACK_BUTTON(back);
    
    self.itemsArray = [NSKeyedUnarchiver unarchiveObjectWithFile:[BSPathManager pathForHistoryFileName:[self.filenamesArray objectAtIndex:self.dataIndex]]];
    
    self.imageLoader = [[[BSImageLoader alloc] init] autorelease];
    self.imageLoader.delegate = self;
    
    //show image view
    {
        
        self.showImageView = [[[BSZoomScrollView alloc] init] autorelease];
        self.showImageView.frame = [UIScreen mainScreen].bounds;
        self.showImageView.backgroundColor = [UIColor blackColor];
        self.showImageView.userInteractionEnabled = YES;
        
        
        UITapGestureRecognizer  *recognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideBigImageView:)] autorelease];
        [self.showImageView addGestureRecognizer:recognizer];
    }
    
    [self addBannerView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    if (self.filenamesArray == nil) {
        [self back];
    }
    
    [BSSystem trackBeginView:@"下载内容"];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [BSSystem trackEndView:@"下载内容"];
}

#pragma mark - bannerview

- (void)addBannerView
{

}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)refreshImage:(id)sender
{
    
    if ([BSSettings sharedInstance].onlyWifDownload) {//仅wifi情况下载
        
        if ([BSSettings sharedInstance].enable3G) {//当前3g
            
            UIAlertView  *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"当前网络为3G，设置为仅Wifi情况下载，您确定要下载图片？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alertView.tag = kAlert3GChangeWifTag;
            [alertView show];
            [alertView release];
            
        } else if (![BSSystem isEnableInternetConnection]) {//当前无网络
            
            UIAlertView  *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"当前无网络" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"我知道了", nil];
            [alertView show];
            [alertView release];
            
        } else if ([BSSettings sharedInstance].enableWifi) {
            [self refreshTable];
        }
    }
    else {//wifi和3g情况下载
        
        if (![BSSystem isEnableInternetConnection]) {//无网络
            
            UIAlertView  *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"当前无网络" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"我知道了", nil];
            [alertView show];
            [alertView release];
            
        } else {
            [self refreshTable];
        }
    
   }
    
}

- (void)refreshTable
{
    _needRefresh = YES;
    [self.tableView reloadData];
}


#pragma mark - show/hide image view

- (void)showBigImageView:(id)sender
{
    [UIApplication sharedApplication].statusBarHidden = YES;
    
    [[UIApplication sharedApplication].keyWindow addSubview:showImageView];
    
    BSImageCell  *cell = (BSImageCell *)sender;
    
    BSImageItem  *item = cell.items;
    
    self.showImageView.item = item;
    
}

#pragma mark - tableview delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.itemsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString  *cellIdentifier = @"cell";
    
    BSImageCell  *cell = nil;
    if (cell == nil) {
        cell = [[[BSImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        cell.delegate = self;
    }
    
    BSImageItem  *items = [self.itemsArray objectAtIndex:indexPath.row];
    
    cell.items = items;
    
    if (items.image) {
        
        cell.imageView.image = items.image;
        
    }
    else {
        
        UIImage  *image = [UIImage imageWithContentsOfFile:[BSPathManager imageCacheForURL:items.showImageURL]];
        if (image) {
            items.image = image;
            cell.imageView.image = items.image;
        }
        else {
            if (!tableView.dragging && !tableView.decelerating) {
                [self startLoadImageUrl:items.showImageURL indexPath:indexPath];
            }
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < [self.itemsArray count]) {
        
        BSImageItem  *item = [self.itemsArray objectAtIndex:indexPath.row];
        
        return [BSImageCell heightForItem:item];
    }
    return 0;
}

#pragma mark - scrollview

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        [self scrollViewEnd:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewEnd:scrollView];
}

- (void)scrollViewEnd:(UIScrollView *)scrollView
{
    NSArray  *array = [self.tableView indexPathsForVisibleRows];
    for (NSIndexPath *indexPath in array) {
        
        int row = indexPath.row;
        
        BSImageItem  *item = [self.itemsArray objectAtIndex:row];
        
        [self startLoadImageUrl:item.showImageURL indexPath:indexPath];
    }
}



#pragma mark - loadimage
- (void)startLoadImageUrl:(NSURL *)url indexPath:(NSIndexPath *)indexPath
{
    
    if (_needRefresh) {
     
        NSDictionary  *info = [NSDictionary dictionaryWithObjectsAndKeys:indexPath, @"indexPath", nil];
        
        [self.imageLoader loadImageWithURL:url info:info];
        
    }
    else {
        
    }

}


#pragma mark - imageLoader delegate

- (void)showImage:(UIImage *)image info:(NSDictionary *)info
{
    NSIndexPath  *indexPath = [info objectForKey:@"indexPath"];
    
    if (indexPath) {
        BSImageItem  *item = [self.itemsArray objectAtIndex:indexPath.row];
        
        item.image = image;
        
        BSImageCell  *cell = (BSImageCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        cell.imageView.image = image;
    }

}


- (void)BSImageLoader:(BSImageLoader *)aImageLoader existImage:(UIImage *)image info:(NSDictionary *)info
{
    [self showImage:image info:info];
}

- (void)BSImageLoader:(BSImageLoader *)imageLoader image:(UIImage *)image info:(NSDictionary *)info
{
    [self showImage:image info:info];
    
}

- (void)BSImageLoader:(BSImageLoader *)imageLoader error:(NSError *)error info:(NSDictionary *)info
{

}

#pragma mark - BSImageCell delegate
- (void)onClickBSImageCell:(BSImageCell *)cell
{
    [self showBigImageView:cell];
}

#pragma mark - alertview delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == alertView.cancelButtonIndex) {
        return;
    }
    
    switch (alertView.tag) {
        case kAlert3GChangeWifTag:
            
            [BSSettings sharedInstance].onlyWifDownload = NO;
            [self refreshTable];
            [[NSNotificationCenter defaultCenter] postNotificationName:kNeedRefreshNotification object:nil];
            break;
            
        default:
            break;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
