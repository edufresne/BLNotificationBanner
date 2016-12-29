//
//  ViewController.m
//  BLNotificationBanner
//
//  Created by Eric Dufresne on 2016-12-26.
//  Copyright © 2016 Eric Dufresne. All rights reserved.
//

#import "ViewController.h"
#import "BLNotificationBanner.h"

@interface ViewController (){
    NSTimer *timer;
}
@property (strong, nonatomic) UIView *notificationView;
@property (strong, nonatomic) UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(post) userInfo:nil repeats:YES];
    
}
-(void)post{
    BLNotificationBanner *banner = [BLNotificationBanner defaultBannerWithNavbarHeight:self.navigationController.navigationBar.frame.size.height];
    banner.message = @"Hello World";
    [self.view addSubview:banner];
    [banner show];
}


@end
