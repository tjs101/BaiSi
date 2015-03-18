//
//  BSNavigationViewController.m
//  BaiSi
//
//  Created by tjs on 13-9-9.
//  Copyright (c) 2013年 tjs. All rights reserved.
//

#import "BSNavigationViewController.h"

@interface BSNavigationViewController ()

@end

@implementation BSNavigationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"bar_background"] forBarMetrics:UIBarMetricsDefault];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
