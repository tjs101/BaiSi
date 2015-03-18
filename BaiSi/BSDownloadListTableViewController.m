//
//  BSDownloadListTableViewController.m
//  BaiSi
//
//  Created by tjs on 13-9-14.
//  Copyright (c) 2013年 tjs. All rights reserved.
//

#import "BSDownloadListTableViewController.h"
#import "BSSettings.h"
#import "BSPathManager.h"
#import "UIViewController+MMDrawerController.h"
#import "BSMainViewController.h"

#define  kPerPage 100

@interface BSDownloadListTableViewController ()

@end

@implementation BSDownloadListTableViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadView) name:kChangePageCountNotification object:nil];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}

- (void)reloadView
{

    CGFloat pointY = [BSSettings sharedInstance].currentPointYForItemKey;
    
    self.tableView.contentOffset = CGPointMake(0, pointY);
    
    [self.tableView reloadData];
}

#pragma mark - tableview delegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [BSSettings sharedInstance].currentMaxCountForItemKey/kPerPage;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = nil;
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

    int perPage = kPerPage;
    int startPage = indexPath.row * perPage;

    if ([BSSettings sharedInstance].currentPageForItemKey == startPage/kPageSize + 1) {
        cell.textLabel.textColor = [UIColor redColor];
    }
    
    NSString  *startStr = nil;
    
    if (startPage == 0) {
        startStr = @"从首页开始阅读";
    }
    else {
        startStr = [NSString stringWithFormat:@"从%d条开始阅读",startPage];
    }
    
    cell.textLabel.text = startStr;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished){
        
    [[BSSettings sharedInstance] setCurrentPageForItemKey:indexPath.row * kPageSize + 1];
    [[BSSettings sharedInstance] setCurrentPointYForItemKey:self.tableView.contentOffset.y];
    
        NSArray  *views = self.mm_drawerController.centerViewController.childViewControllers;
        if ([views count] <= 0) {
            Log(@"view is null");
            return;
        }
        
        BSMainViewController  *mainViewCtrl = [views objectAtIndex:0];
        
        [mainViewCtrl choosePage];
        
        
        [self.tableView reloadData];
    }];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView  *footerView = [[[UIView alloc] initWithFrame:self.tableView.frame] autorelease];
    return footerView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
