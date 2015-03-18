//
//  BSDownloadHistoryViewController.m
//  BaiSi
//
//  Created by quentin on 13-9-11.
//  Copyright (c) 2013年 tjs. All rights reserved.
//

#import "BSDownloadHistoryViewController.h"
#import "BSPathManager.h"
#import "BSLocalHistoryListViewController.h"
#import "BSSystem.h"

@interface BSDownloadHistoryViewController ()

@property   (nonatomic, retain)  NSMutableArray   *historysArray;

@end

@implementation BSDownloadHistoryViewController
@synthesize historysArray;

- (void)dealloc
{
    [historysArray release];

    [super dealloc];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    SET_SCROLL_NAVIGATION_TITLE(NSLocalizedString(@"下载历史", nil));
    
    ADD_BACK_BUTTON(back);
    
    //编辑
    ADD_NAVIGATION_RIGHT_BUTTON(editAction:, @"编辑");
    
    self.historysArray = [NSMutableArray arrayWithArray:[BSPathManager arrayFormDatapath]];
    
    [self addBannerView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [BSSystem trackBeginView:@"下载列表"];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [BSSystem trackEndView:@"下载列表"];
}

#pragma mark - bannerview

- (void)addBannerView
{

}

- (void)back
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - deit action

- (void)editAction:(id)sender
{
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    
    UIButton *button = (UIButton *)sender;
    if (self.tableView.editing) {
        [button setTitle:@"完成" forState:UIControlStateNormal];
    } else {
        [button setTitle:@"编辑" forState:UIControlStateNormal];
    }
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [self.historysArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = nil;
    
    // Configure the cell...
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.textLabel.text = [self.historysArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BSLocalHistoryListViewController  *viewCtrl = [[[BSLocalHistoryListViewController alloc] initWithArray:self.historysArray index:indexPath.row] autorelease];
    [self.navigationController pushViewController:viewCtrl animated:YES];
    
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        NSString *fileName = [self.historysArray objectAtIndex:indexPath.row];
        NSString *path = [BSPathManager pathForHistoryFileName:fileName];
        
        if ([BSPathManager deleteFileForPath:path]) {
            [self.historysArray removeObject:fileName];
            [[NSNotificationCenter defaultCenter] postNotificationName:kNeedRefreshNotification object:nil];
        }
        else {
            
            UIAlertView  *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"删除失败，请重试" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"我知道了", nil];
            [alertView show];
            [alertView release];
            
        }
        
        [self.tableView reloadData];
    }
}



@end
