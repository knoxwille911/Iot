//
//  ReflectorViewController.m
//  Iot
//
//  Created by Pavel Skovorodko on 4/10/18.
//  Copyright © 2018 DMTech. All rights reserved.
//

#import "IotRecordReflectorViewer.h"
#import "IotRecordReflectorView.h"

@interface IotRecordReflectorViewer()

@property (nonatomic, strong, readwrite) IotRecordReflectorView *reflectorView;

@end

@implementation IotRecordReflectorViewer

+ (IotRecordReflectorViewer *)sharedInstance {
    static IotRecordReflectorViewer *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[IotRecordReflectorViewer alloc] init];
    });
    return sharedInstance;
}

#pragma mark - Init

- (instancetype)init {
    if (self = [super init]) {
        self.reflectorView = [[IotRecordReflectorView alloc] initWithFrame:CGRectZero];
        self.reflectorView.translatesAutoresizingMaskIntoConstraints = NO;
        self.reflectorView.alpha = 0.f;
        
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(appWillResignActive) name:UIApplicationWillResignActiveNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

#pragma mark - Notification methods

- (void)appWillResignActive {
    [self hideReflectorView];
}

#pragma mark - Public methods

- (void)showRecordReflectorViewInViewIfNeeded:(UIView *)view {
    [view addSubview:self.reflectorView];
    
    [self.reflectorView.centerXAnchor constraintEqualToAnchor:view.centerXAnchor constant:0.f].active = YES;
    [self.reflectorView.centerYAnchor constraintEqualToAnchor:view.centerYAnchor constant:-100.f].active = YES;
    [self.reflectorView.leadingAnchor constraintEqualToAnchor:view.leadingAnchor constant:30.f].active = YES;
    [self.reflectorView.trailingAnchor constraintEqualToAnchor:view.trailingAnchor constant:-30.f].active = YES;
    
    [UIView animateWithDuration:0.25f animations:^{
        self.reflectorView.alpha = 1.f;
    }];
}

- (void)hideReflectorView {
    [UIView animateWithDuration:0.25f animations:^{
        self.reflectorView.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self.reflectorView removeFromSuperview];
    }];
}

@end
