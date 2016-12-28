//
//  BLNotificationBanner.h
//  BLNotificationBanner
//
//  Created by Eric Dufresne on 2016-12-26.
//  Copyright © 2016 Eric Dufresne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLNotificationBanner : UIView

@property (assign, nonatomic) NSTimeInterval animationTime;

@property (assign, nonatomic) UIViewAnimationOptions animationOptions;

@property (assign, nonatomic) NSTimeInterval messageTime;

@property (assign, nonatomic) NSUInteger verticalPadding;

@property (strong, nonatomic) UIColor *textColor;

@property (strong, nonatomic) UIFont *font;

@property (readonly, nonatomic) BOOL showing;

@property (strong, nonatomic) NSString *message;

@property (assign, nonatomic) CGFloat navbarHeight;

-(id)initWithMessage:(NSString*)message;
-(id)initWithMessage:(NSString*)message navbarHeight:(CGFloat)navbarHeight;
+(instancetype)bannerWithmessage:(NSString*)message;
+(instancetype)bannerWithMessage:(NSString*)message navbarHeight:(CGFloat)navbarHeight;
-(void)show;
-(void)dissapear; //Interrupts message and pre-emptively makes it dissapear

+(BLNotificationBanner*)defaultBanner;
+(BLNotificationBanner*)successBanner;
+(BLNotificationBanner*)failedBanner;
+(BLNotificationBanner*)defaultBannerWithNavbarHeight:(CGFloat)navbarHeight;
+(BLNotificationBanner*)successBannerWithNavbarHeight:(CGFloat)navbarHeight;
+(BLNotificationBanner*)failedBannerWithNavbarHeight:(CGFloat)navbarHeight;
 
@end
