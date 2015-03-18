//
//  BSAboutViewController.m
//  BaiSi
//
//  Created by quentin on 13-9-11.
//  Copyright (c) 2013年 tjs. All rights reserved.
//

#import "BSAboutViewController.h"
#import "BSSystem.h"
#import <QuartzCore/QuartzCore.h>
@interface BSAboutViewController ()

@end

@implementation BSAboutViewController

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
    
    SET_SCROLL_NAVIGATION_TITLE(@"关于我们");
    
    ADD_BACK_BUTTON(back);
    
    UIImage  *iconImage = [UIImage imageNamed:@"about.jpg"];
    
    CGFloat x = (self.view.frame.size.width - iconImage.size.width)/2;
    CGFloat y = 50;
    
    UIImageView  *iconImageView = [[[UIImageView alloc] initWithImage:iconImage] autorelease];
    iconImageView.layer.borderWidth = 1;
    iconImageView.layer.borderColor = [UIColor grayColor].CGColor;
    iconImageView.clipsToBounds = YES;
    iconImageView.layer.cornerRadius = 10;
    iconImageView.frame = CGRectMake(x, y, iconImage.size.width, iconImage.size.height);
    [self.view addSubview:iconImageView];
    
    
    UILabel  *infoLabel = [[[UILabel alloc] init] autorelease];
    infoLabel.backgroundColor = [UIColor clearColor];
    infoLabel.text = @"这里全部数据都来自于网络，收集了网络上比较搞趣的图片和笑料，希望大家喜欢。";
    infoLabel.frame = CGRectMake(10, iconImageView.frame.origin.y + iconImageView.frame.size.height + 30, self.view.frame.size.width - 20, 100);
    infoLabel.numberOfLines = 6;
    [self.view addSubview:infoLabel];
}

- (void)back
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [BSSystem trackBeginView:@"关于"];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [BSSystem trackEndView:@"关于"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
