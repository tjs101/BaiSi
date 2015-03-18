//
//  XMScrollLabel.h
//  ting
//
//  Created by mario on 13-5-29.
//
//

#import <UIKit/UIKit.h>

// XMScrollLabel    可滚动文本的Label

@interface BSScrollLabel : UIView

- (id)initWithFrame:(CGRect)frame duration:(NSTimeInterval)duration andFadeLength:(CGFloat)fadeLength;

@property   (nonatomic, retain) NSString    *text;
@property   (nonatomic, retain) UIFont      *font;
@property   (nonatomic, retain) UIColor     *textColor;
@property   (nonatomic, retain) UIColor     *backgroundColor;

@end
