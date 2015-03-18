//
//  XMZoomScrollView.h
//  ting
//
//  Created by quentin on 13-6-3.
//
//

#import <UIKit/UIKit.h>
#import "BSImageItem.h"

@interface BSZoomScrollView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic, retain)  BSImageItem  *item;

- (void)refreshUI;

@end
