//
//  BSBaseViewController.h
//  BaiSi
//
//  Created by quentin on 13-9-11.
//  Copyright (c) 2013年 tjs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSBaseViewController : UIViewController

- (void)runAsynchronousMainThread:(void (^)())block;

@end
