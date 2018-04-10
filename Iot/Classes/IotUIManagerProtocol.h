//
//  SPUIManagerProtocol.h
//  SpeedTest
//
//  Created by Dmtech on 19.02.18.
//  Copyright © 2018 Dmtech. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IotUIManagerProtocol<NSObject>

-(void)commonInit;
-(void)showHelloAlertForViewController:(UIViewController *)viewController;
-(UITabBarController *)tabbarController;

@end
