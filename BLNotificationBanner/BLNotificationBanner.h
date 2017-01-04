//
//  BLNotificationBanner.h
//  BLNotificationBanner
//
//  Created by Eric Dufresne on 2016-12-26.
//  Copyright © 2016 Eric Dufresne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLNotificationBanner : UIView

//The time in seconds it takes for the banner to animate into/out of the view. Defaults to 0.5
@property (assign, nonatomic) NSTimeInterval animationTime;

//These are the animation options for when the banner animation is done. Defaults to ease in ease out curve
@property (assign, nonatomic) UIViewAnimationOptions animationOptions;

//The time it takes for a message to be in the screen before dissapear is called. If mustDissapearManually = YES then this time does not mean anything as the view will stay until dissapear is called by the user. Defaults to 2.5
@property (assign, nonatomic) NSTimeInterval messageTime;

//If set to YES then the banner will stay in the view forever until dissapear is called manually. Defaults to NO
@property (assign, nonatomic) BOOL mustDissapearManually;

//Spacing between the text and the vertical edges of the banner in points. Defaults to 2
@property (assign, nonatomic) NSUInteger verticalPadding;

//Color of the text in the banner. Defaults to (255, 255, 255, 1)
@property (strong, nonatomic) UIColor *textColor;

//Font of the text in the banner. Defaults to Helvetica Bold 14pt
@property (strong, nonatomic) UIFont *font;

//If YES then the view is currently animating into the view, in the view, or outside the view
@property (readonly, nonatomic) BOOL showing;

//The message text that will be shown in the banner
@property (strong, nonatomic) NSString *message;

//The initial height of the navbar before the text appears. If set to 0 the banner will simply be displayed at the top of the screen. If set to the navbar height of your view, it will display behind and under your navbar. Defaults to 0
@property (assign, nonatomic) CGFloat navbarHeight;

//Constructors
-(id)initWithMessage:(NSString*)message;

-(id)initWithMessage:(NSString*)message navbarHeight:(CGFloat)navbarHeight;

+(instancetype)bannerWithmessage:(NSString*)message;

+(instancetype)bannerWithMessage:(NSString*)message navbarHeight:(CGFloat)navbarHeight;

//Call this to start the animation of the banner into the view.
-(void)show;

//Call this to start the animation of the banner into the view after x seconds.
-(void)showWithDelay:(NSTimeInterval)delay;

//Call this to start th eanimation of the banner leaving the view. If mustDissapearManually = YES then you must call this method manually to star the animation. If not then this method preemptively starts the animation before messageTime
-(void)dissapear;

//Convenience methods. NOTE: You must set the message after calling these.
//Pastel blue banner.
+(BLNotificationBanner*)defaultBanner;

//Pastel green banner.
+(BLNotificationBanner*)successBanner;

//Pastel red banner.
+(BLNotificationBanner*)failedBanner;

//Same convenience methods with navbar height argument
+(BLNotificationBanner*)defaultBannerWithNavbarHeight:(CGFloat)navbarHeight;
+(BLNotificationBanner*)successBannerWithNavbarHeight:(CGFloat)navbarHeight;
+(BLNotificationBanner*)failedBannerWithNavbarHeight:(CGFloat)navbarHeight;
 
@end
