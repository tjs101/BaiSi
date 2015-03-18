//
//  BSHelpViewController.m
//  BaiSi
//
//  Created by quentin on 13-9-13.
//  Copyright (c) 2013年 tjs. All rights reserved.
//

#import "BSHelpViewController.h"

@interface BSHelpViewController ()

@end

@implementation BSHelpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    SET_SCROLL_NAVIGATION_TITLE(@"帮助");
    
    ADD_BACK_BUTTON(back);
    
    NSString  *infoStr = @"因为图片和帖子很多，当阅读很早以前的图片时，需要翻看很久才可以找到，这里可以通过书签进行查看。\n书签也有记录上次阅读位置的功能。";
    
    UILabel   *helpLabel = [[[UILabel alloc] init] autorelease];
    helpLabel.backgroundColor = [UIColor clearColor];
    helpLabel.textColor = [UIColor blackColor];
    helpLabel.text = infoStr;
    helpLabel.numberOfLines = 10;
    helpLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:helpLabel];
    
    CGFloat leftCap = 10;
    CGFloat topCap = 20;
    
    [helpLabel sizeToFit];
    
    CGSize  size = [infoStr sizeWithFont:helpLabel.font constrainedToSize:CGSizeMake(self.view.frame.size.width - leftCap * 2, MAXFLOAT)];
    
    helpLabel.frame = CGRectMake(leftCap, topCap, size.width, size.height);
    
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

@end
