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
    
    UIImage *converastionImage = [UIImage imageNamed:@"tab-Ella-active-icon-inactive"];
    UIImage *converastionImageSel = [UIImage imageNamed:@"tab-Ella-active-icon-active"];
    converastionImage = [converastionImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    converastionImageSel = [converastionImageSel imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    rootNavConversationVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Ella", @"Ella") image:converastionImage selectedImage:converastionImageSel];
    
    IotDevicesViewController *devicesViewController = [[IotDevicesViewController alloc] init];
    UINavigationController *devicesNavVC = [[UINavigationController alloc] initWithRootViewController:devicesViewController];
    UIImage *devicesImage = [UIImage imageNamed:@"tab-devices-icon-inactive"];
    UIImage *devicesImageSel = [UIImage imageNamed:@"tab-devices-icon-active"];
    devicesImage = [devicesImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    devicesImageSel = [devicesImageSel imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    devicesNavVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Devices", @"Devices") image:devicesImage selectedImage:devicesImageSel];
    
    IotNotificationsViewController *notificationsViewController = [[IotNotificationsViewController alloc] init];
    UINavigationController *notificationNavVC = [[UINavigationController alloc] initWithRootViewController:notificationsViewController];
    notificationNavVC.navigationBar.topItem.title = @"";
    UIImage *notificationsImage = [UIImage imageNamed:@"tab-notification-icon-inactive"];
    UIImage *notificationsImageSel = [UIImage imageNamed:@"tab-notification-icon-active"];
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
//    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    
    window.rootViewController = _tabBarController;
    
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showHelloAlertForViewController:rootNavConversationVC];
    });
}


-(void)showHelloAlertForViewController:(UIViewController *)viewController {
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:NSLocalizedString(@"Hi, its Ella. How can I help?", @"Hi, its Ella. How can I help?")
                                 message:NSLocalizedString(@"Press mic button to speak to me, type a message to chat or press any of the navigation tabs above to explore my UI", @"Press mic button to speak to me, type a message to chat or press any of the navigation tabs above to explore my UI")
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    //Add Buttons
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:NSLocalizedString(@"OK", @"OK")
                                style:UIAlertActionStyleCancel
                                handler:^(UIAlertAction * action) {
                                    //Handle your yes please button action here
                                }];

    [alert addAction:yesButton];
    
    [viewController presentViewController:alert animated:YES completion:nil];
}


-(UITabBarController *)tabbarController {
    return _tabBarController;
}

@end

