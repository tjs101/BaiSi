//
//  XMScrollLabel.m
//  ting
//
//  Created by mario on 13-5-29.
//
//

#import "BSScrollLabel.h"
#import <QuartzCore/CALayer.h>
#import <QuartzCore/CAGradientLayer.h>

#define kTimerInterval      0.15

@interface UIView (FindUIViewController)
- (UIViewController *) firstAvailableUIViewController;
- (id) traverseResponderChainForUIViewController;
@end

@implementation UIView (FindUIViewController)
- (UIViewController *) firstAvailableUIViewController {
    // convenience function for casting and to "mask" the recursive function
    return (UIViewController *)[self traverseResponderChainForUIViewController];
}

- (id) traverseResponderChainForUIViewController {
    id nextResponder = [self nextResponder];if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return nextResponder;
    } else if ([nextResponder isKindOfClass:[UIView class]]) {
        return [nextResponder traverseResponderChainForUIViewController];
    } else {
        return nil;
    }
}
@end

@interface BSScrollLabel () {
    UILabel         *_label;
    CGSize          _origSize;
    BOOL            _isMoveBackward;
    NSTimeInterval         _lengthOfScroll;
    NSTimeInterval         _duration;
    NSTimeInterval         _delay;
    CGFloat         _fadeLength;
    
    CGRect          _homeLabelFrame;
    CGRect          _alwaysLabelFrame;
    CGSize          _labelSize;
    
    UIViewAnimationOptions  _animationOptions;
}

@end

@implementation BSScrollLabel

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame duration:(NSTimeInterval)duration andFadeLength:(CGFloat)fadeLength
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _lengthOfScroll = duration;
        _fadeLength = MIN(fadeLength, self.frame.size.width/2);
        UILabel *label = [[UILabel alloc] init];
        _label = label;
        [self addSubview:label];
        [label release];
        
        _animationOptions = (UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction);
        
        [self setupFade];
        
        [self setupNotify];
    }
    
    return self;
}

- (void)setupNotify
{
    // Add notification observers
    // UINavigationController view controller change notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observedViewControllerChange:) name:@"UINavigationControllerDidShowViewControllerNotification" object:nil];
    // UIApplication state notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(restartLabel) name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(restartLabel) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shutdownLabel) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shutdownLabel) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)observedViewControllerChange:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    UIViewController *fromController = [userInfo objectForKey:@"UINavigationControllerLastVisibleViewController"];
    UIViewController *toController = [userInfo objectForKey:@"UINavigationControllerNextVisibleViewController"];
    
    UIViewController *ownController = [self firstAvailableUIViewController];
    
    // bug fixes:
    if ([ownController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *) ownController;
        ownController = nav.topViewController;
    }
    
    if ([fromController isEqual:ownController] || ownController == nil) {
        [self shutdownLabel];
    }
    else if ([toController isEqual:ownController]) {
        [self restartLabel];
    }
}

- (void)restartLabel
{
    [self returnLabelToOriginImmediately];
    
    if (self.labelShouldScroll) {
        [self beginScroll];
    }
}

- (void)shutdownLabel
{
    [self returnLabelToOriginImmediately];
}

- (void)setupFade
{
    if (_fadeLength != 0.0f) {
        CAGradientLayer *mask = [CAGradientLayer layer];
        
        mask.bounds = self.layer.bounds;
        mask.position = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        
        NSObject *transparent = (NSObject *) [UIColor clearColor].CGColor;
        NSObject *opaque = (NSObject *) [UIColor blackColor].CGColor;
        
        mask.startPoint = CGPointMake(0, CGRectGetMidY(self.frame));
        mask.endPoint = CGPointMake(1., CGRectGetMidY(self.frame));
        CGFloat fadePoint = (CGFloat) _fadeLength / self.frame.size.width;
        [mask setColors: [NSArray arrayWithObjects: transparent, opaque, opaque, transparent, nil]];
        [mask setLocations: [NSArray arrayWithObjects:
                                     [NSNumber numberWithDouble: 0.0],
                                     [NSNumber numberWithDouble: fadePoint],
                                     [NSNumber numberWithDouble: 1 - fadePoint],
                                     [NSNumber numberWithDouble: 1.0],
                                     nil]];
        
        self.layer.mask = mask;
    }
    else {
        self.layer.mask = nil;
    }
}

- (void)resetFade
{
    self.layer.mask = nil;
}

- (void)scrollHomeWithInterval:(NSTimeInterval)interval
{
    [UIView animateWithDuration:interval
                          delay:_delay
                        options:_animationOptions
                     animations:^{
                         _label.frame = _homeLabelFrame;
                     }
                     completion:^(BOOL finished){
                         if (finished) {
                             [self scrollAlwaysWithInterval:interval];
                         }
                     }];
}

- (void)scrollAlwaysWithInterval:(NSTimeInterval)interval
{
    [UIView animateWithDuration:interval
                          delay:_delay
                        options:_animationOptions
                     animations:^{
                         _label.frame = _alwaysLabelFrame;
                     }
                     completion:^(BOOL finished){
                         if (finished) {
                             [self scrollHomeWithInterval:interval];
                         }
                     }];
}

- (void)beginScroll
{
    [self scrollAlwaysWithInterval:_duration];
}

- (void)returnLabelToOriginImmediately
{
    // cancel all animations
    [_label.layer removeAllAnimations];
    _label.frame = _homeLabelFrame;
}

- (BOOL)labelShouldScroll
{
    return self.bounds.size.width < _labelSize.width;
}

- (void)setText:(NSString *)aText
{
    if (aText.length <= 0 || [aText isEqualToString:_label.text]) return;
    
    _label.text = aText;
    
    CGSize maxLabelSize = CGSizeMake(CGFLOAT_MAX, self.frame.size.height);
    CGSize expectedLabelSize = [_label.text sizeWithFont:_label.font
                                       constrainedToSize:maxLabelSize
                                           lineBreakMode:_label.lineBreakMode];
    _labelSize = expectedLabelSize;
    if ([self labelShouldScroll]) {
        _homeLabelFrame = CGRectMake(_fadeLength, 0,
                                     expectedLabelSize.width, self.bounds.size.height);
        _alwaysLabelFrame = CGRectOffset(_homeLabelFrame,
                                         -expectedLabelSize.width + (self.bounds.size.width - _fadeLength*2), 0);
        
        [self setupFade];
        _label.textAlignment = UITextAlignmentLeft;
    }
    else {
        _homeLabelFrame = CGRectMake((self.bounds.size.width - expectedLabelSize.width)/2, (self.bounds.size.height - expectedLabelSize.height)/2,
                                     expectedLabelSize.width, expectedLabelSize.height);
        _alwaysLabelFrame = _homeLabelFrame;
        
        [self resetFade];
        _label.textAlignment = UITextAlignmentCenter;
    }
    
    [self returnLabelToOriginImmediately];
    
    _duration = _lengthOfScroll;
    
    if ([self labelShouldScroll]) {
        // begin scroll
        [self beginScroll];
    }
}

- (NSString *)text
{
    return _label.text;
}

- (void)setTextColor:(UIColor *)textColor
{
    _label.textColor = textColor;
}

- (UIColor *)textColor
{
    return _label.textColor;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    _label.backgroundColor = backgroundColor;
}

- (UIColor *)backgroundColor
{
    return _label.backgroundColor;
}

- (void)setFont:(UIFont *)font
{
    _label.font = font;
}

- (UIFont *)font
{
    return _label.font;
}

@end
