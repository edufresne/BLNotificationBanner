//
//  ViewController.m
//  BLNotificationBanner
//
//  Created by Eric Dufresne on 2016-12-26.
//  Copyright © 2016 Eric Dufresne. All rights reserved.
//

#import "ViewController.h"
#import "BLNotificationBanner.h"

@interface ViewController ()
@property (strong, nonatomic) UIView *notificationView;
@property (strong, nonatomic) UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.userInteractionEnabled = YES;
    
}
-(void)viewDidAppear:(BOOL)animated{
    BLNotificationBanner *banner = [BLNotificationBanner defaultBannerWithNavbarHeight:self.navigationController.navigationBar.frame.size.height];
    banner.message = @"Cannot Refresh. No Internet Connection";
    [self.view addSubview:banner];
    [banner show];
}


@end
