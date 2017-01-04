
//
//  BLNotificationBanner.m
//  BLNotificationBanner
//
//  Created by Eric Dufresne on 2016-12-26.
//  Copyright © 2016 Eric Dufresne. All rights reserved.
//

#import "BLNotificationBanner.h"

@interface BLNotificationBanner (){
    NSTimer *timer;
    NSTimer *delayTimer;
    BOOL includesStatusBar;
}
@property (strong, nonatomic) UILabel *label;
@end

@implementation BLNotificationBanner
@synthesize label;

//Constructors
-(id)initWithMessage:(NSString *)message{
    if (self = [super initWithFrame:CGRectZero]){
        _animationTime = 0.5;
        _animationOptions = UIViewAnimationOptionCurveEaseInOut;
        _messageTime = 2.5;
        _verticalPadding = 2;
        _showing = NO;
        _message = message;
        _navbarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
        _mustDissapearManually = NO;
        self.backgroundColor = [UIColor redColor];
        self.textColor = [UIColor whiteColor];
        self.font = [UIFont fontWithName:@"Helvetica" size:14];
        self.alpha = 0;
    }
    return self;
}
-(id)initWithMessage:(NSString *)message navbarHeight:(CGFloat)navbarHeight{
    if (self = [super initWithFrame:CGRectZero]){
        _animationTime = 0.5;
        _animationOptions = UIViewAnimationOptionCurveEaseInOut;
        _messageTime = 2.5;
        _verticalPadding = 2;
        _showing = NO;
        _message = message;
        _navbarHeight = navbarHeight;
        _mustDissapearManually = NO;
        self.backgroundColor = [UIColor redColor];
        self.textColor = [UIColor whiteColor];
        self.font = [UIFont fontWithName:@"Helvetica" size:14];
        self.alpha = 0;
    }
    return self;
}
+(instancetype)bannerWithmessage:(NSString *)message{
    return [[self alloc] initWithMessage:message];
}
+(instancetype)bannerWithMessage:(NSString *)message navbarHeight:(CGFloat)navbarHeight{
    return [[self alloc] initWithMessage:message navbarHeight:navbarHeight];
}
//View Handling Methods
-(void)didMoveToSuperview{
    if (self.superview != nil){
        label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.backgroundColor = self.backgroundColor;
        label.font = self.font;
        label.textColor = self.textColor;
        label.text = self.message;
        label.textAlignment = NSTextAlignmentCenter;
        [label sizeToFit];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        
        CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
        CGFloat height = self.navbarHeight+label.frame.size.height+self.verticalPadding*2-(22-statusBarHeight);
            
        //label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, self.superview.frame.size.width, label.frame.size.height);
        
        self.frame = CGRectMake(0, 0, self.superview.frame.size.width, height);
        [self addSubview:label];
        //label.center = CGPointMake(self.superview.center.x, self.frame.size.height-label.frame.size.height/2-_verticalPadding);
        int vPad = (int)_verticalPadding;
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:label.frame.size.height];
        
        NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:-vPad];
        
        NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeLeftMargin relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeftMargin multiplier:1 constant:0];
        
        NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeRightMargin relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRightMargin multiplier:1 constant:0];
        
        [self addConstraint:bottomConstraint];
        [self addConstraint:leftConstraint];
        [self addConstraint:rightConstraint];
        [label addConstraint:heightConstraint];
        
        self.center = CGPointMake(self.superview.center.x, -self.frame.size.height/2);
    }
}
-(void)didChangeOrientation{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.superview.frame.size.width, self.frame.size.height);
}
//User Methods
-(void)show{
    if (_showing)
        return;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChangeOrientation) name:UIDeviceOrientationDidChangeNotification object:nil];
    _showing = YES;
    [UIView animateWithDuration:self.animationTime delay:0 options:self.animationOptions animations:^{
        self.alpha = 1;
        self.center = CGPointMake(self.center.x, (self.frame.size.height/2)+(self.verticalPadding*2)+label.frame.size.height);
    } completion:^(BOOL finished) {
        if (!self.mustDissapearManually){
            timer = [NSTimer scheduledTimerWithTimeInterval:self.messageTime target:self selector:@selector(dissapear) userInfo:nil repeats:NO];
        }
    }];
}
-(void)showWithDelay:(NSTimeInterval)delay{
    delayTimer = [NSTimer scheduledTimerWithTimeInterval:delay target:self selector:@selector(show) userInfo:nil repeats:NO];
}
-(void)dissapear{
    if (!_showing)
        return;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    _showing = NO;
    if (timer){
        [timer invalidate];
        timer = nil;
    }
    [UIView animateWithDuration:self.animationTime delay:0 options:self.animationOptions animations:^{
        self.alpha = 0;
        self.center = CGPointMake(self.center.x, -self.frame.size.height/2);
    } completion:^(BOOL finished) {
        if (self.superview != nil){
            [self removeFromSuperview];
        }
    }];
}
//Convenience Initializers
+(BLNotificationBanner*)defaultBanner{
    BLNotificationBanner *banner = [[BLNotificationBanner alloc] initWithMessage:@""];
    banner.backgroundColor = [UIColor colorWithRed:0.298 green:0.851 blue:0.392 alpha:1.00];
    return banner;
}
+(BLNotificationBanner*)successBanner{
    BLNotificationBanner *banner = [[BLNotificationBanner alloc] initWithMessage:@""];
    banner.backgroundColor = [UIColor colorWithRed:0.000 green:0.478 blue:1.000 alpha:1.00];
    return banner;
}
+(BLNotificationBanner*)failedBanner{
    BLNotificationBanner *banner = [[BLNotificationBanner alloc] initWithMessage:@""];
    banner.backgroundColor = [UIColor colorWithRed:1.000 green:0.231 blue:0.188 alpha:1.00];
    return banner;
}
+(BLNotificationBanner*)successBannerWithNavbarHeight:(CGFloat)navbarHeight{
    BLNotificationBanner *banner = [[BLNotificationBanner alloc] initWithMessage:@"" navbarHeight:navbarHeight];
    banner.backgroundColor = [UIColor colorWithRed:0.298 green:0.851 blue:0.392 alpha:1.00];
    return banner;
}
+(BLNotificationBanner*)defaultBannerWithNavbarHeight:(CGFloat)navbarHeight{
    BLNotificationBanner *banner = [[BLNotificationBanner alloc] initWithMessage:@"" navbarHeight:navbarHeight];
    banner.backgroundColor = [UIColor colorWithRed:0.000 green:0.478 blue:1.000 alpha:1.00];
    return banner;
}
+(BLNotificationBanner*)failedBannerWithNavbarHeight:(CGFloat)navbarHeight{
    BLNotificationBanner *banner = [[BLNotificationBanner alloc] initWithMessage:@"" navbarHeight:navbarHeight];
    banner.backgroundColor = [UIColor colorWithRed:1.000 green:0.231 blue:0.188 alpha:1.00];
    return banner;
}
@end
