//
//  SPUIManager.m
//  SpeedTest
//
//  Created by Dmtech on 19.02.18.
//  Copyright © 2018 Dmtech. All rights reserved.
//

#import "IotUIManager.h"
#import "IotDevicesViewController.h"
#import "IotConversationDetailViewController.h"
#import "IotNotificationsViewController.h"
#import "UIColor+SPColors.h"

@interface IotUIManager() {
    UITabBarController *_tabBarController;
}

@property (nonatomic, strong) id<IotUIManagerInjection>injection;

@end


@implementation IotUIManager

- (instancetype)initWithInjection:(id<IotUIManagerInjection>)injection {
    if (self = [super init]) {
        self.injection = injection;
    }
    return self;
}


-(void)commonInit {
    IotConversationDetailViewController *rootConversationVC = [IotConversationDetailViewController new];
    UINavigationController *rootNavConversationVC = [[UINavigationController alloc] initWithRootViewController:rootConversationVC];
    rootNavConversationVC.navigationBar.topItem.title = @"";
    
    UIImage *converastionImage = [UIImage imageNamed:@"tab-tests-inactive-icon"];
    UIImage *converastionImageSel = [UIImage imageNamed:@"tab-tests-active-icon"];
    converastionImage = [converastionImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    converastionImageSel = [converastionImageSel imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    rootNavConversationVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Ella", @"Ella") image:converastionImage selectedImage:converastionImageSel];
    
    IotDevicesViewController *devicesViewController = [[IotDevicesViewController alloc] init];
    UINavigationController *devicesNavVC = [[UINavigationController alloc] initWithRootViewController:devicesViewController];
    UIImage *devicesImage = [UIImage imageNamed:@"tab-shedule-inactive-icon"];
    UIImage *devicesImageSel = [UIImage imageNamed:@"tab-schedule-active-icon"];
    devicesImage = [devicesImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    devicesImageSel = [devicesImageSel imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    devicesNavVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Devices", @"Devices") image:devicesImage selectedImage:devicesImageSel];
    
    IotNotificationsViewController *notificationsViewController = [[IotNotificationsViewController alloc] init];
    UINavigationController *notificationNavVC = [[UINavigationController alloc] initWithRootViewController:notificationsViewController];
    notificationNavVC.navigationBar.topItem.title = @"";
    UIImage *notificationsImage = [UIImage imageNamed:@"tab-history-inactive-icon"];
    UIImage *notificationsImageSel = [UIImage imageNamed:@"tab-history-active-icon"];
    notificationsImage = [notificationsImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    notificationsImageSel = [notificationsImageSel imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    notificationNavVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Notification", @"Notification") image:notificationsImage selectedImage:notificationsImageSel];
    
    _tabBarController = [[UITabBarController alloc] init];
    _tabBarController.viewControllers = @[rootNavConversationVC, devicesNavVC, notificationNavVC];
    _tabBarController.tabBar.barTintColor = [UIColor tabBarBackgroundColor];
    
    _tabBarController.tabBar.barStyle = UIBarStyleBlack;
    _tabBarController.tabBar.translucent = NO;
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor tabBarTitleTextColor] }
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor tabBarSelectedTitleTextColor] }
                                             forState:UIControlStateSelected];

    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    [[UINavigationBar appearance] setBarTintColor:UIColor.navigationBarBackgroundColor];
    [[UINavigationBar appearance] setTintColor:UIColor.navigationBarTintColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : UIColor.navigationBarTextColor,
                                                           NSFontAttributeName : [UIFont systemFontOfSize:20.f weight:UIFontWeightRegular]}];
    
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    
    window.rootViewController = _tabBarController;
}

@end

