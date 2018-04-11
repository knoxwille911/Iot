//
//  ReflectorViewController.h
//  Iot
//
//  Created by Pavel Skovorodko on 4/10/18.
//  Copyright © 2018 DMTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IotRecordReflectorView;

@interface IotRecordReflectorViewer : NSObject

@property (nonatomic, strong, readonly) IotRecordReflectorView *reflectorView;

+ (IotRecordReflectorViewer *)sharedInstance;
- (void)showRecordReflectorViewInViewIfNeeded:(UIView *)view;
- (void)hideReflectorView;

@end
