//
//  UIColor+PCColors.m
//  PEN
//
//  Created by João Carreira on 03/03/16.
//  Copyright © 2016 DarkMatterAB. All rights reserved.
//

#import "UIColor+SPColors.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation UIColor (SPColors)


#pragma mark - Public

+ (UIColor *)colorFromHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:alpha];
}

#pragma mark - common colors

+(UIColor *)tabBarBackgroundColor {
    return UIColorFromRGB(0x253345);
}


+(UIColor *)tabBarTitleTextColor {
    return UIColorFromRGB(0xabb5c0);
}


+(UIColor *)tabBarSelectedTitleTextColor {
    return UIColorFromRGB(0xffffff);
}


+(UIColor *)navigationBarBackgroundColor {
    return UIColorFromRGB(0x16273a);
}


+(UIColor *)navigationBarTintColor {
    return UIColorFromRGB(0xffffff);
}


+(UIColor *)navigationBarTextColor {
    return UIColorFromRGB(0xffffff);
}


+(UIColor *)navigationBarShadowColor {
    return UIColorFromRGB(0x000000);
}


#pragma mark - root view controller colors

+(UIColor *)rootTableViewTextColor {
    return UIColorFromRGB(0xffffff);
}


#pragma mark - test results table view colors

+(UIColor *)testResultsTableViewBackgroundColor {
    return UIColor.clearColor;
}

+(UIColor *)testResultsTableViewCellBackgroundColor {
    return [UIColorFromRGB(0x3c699a) colorWithAlphaComponent:0.2f];
}

+(UIColor *)testResultsTableViewCellTextColor {
    return UIColorFromRGB(0xffffff);
}

+(UIColor *)testResultsTableViewCellHeaderColor {
    return UIColor.clearColor;
}


#pragma mark - latency test view controller colors

+(UIColor *)latencyTestHostLabelColor {
    return UIColorFromRGB(0xffffff);
}

+(UIColor *)latencyTestHostFieldBackgroundColor {
    return UIColorFromRGB(0xe8e8e8);
}

+(UIColor *)latencyTestHostFieldTextColor {
    return UIColorFromRGB(0x6b6b6b);
}

+(UIColor *)latencyTestHostFieldBorderColor {
    return UIColorFromRGB(0x325883);
}


#pragma mark - ftp view controller colors

+(UIColor *)ftpTestBackgroundColor {
    return UIColorFromRGB(0xffffff);
}


#pragma mark - youtube test view controller colors

+(UIColor *)youtubeTestPlayerBorderColor {
    return UIColorFromRGB(0x325883);
}


#pragma mark - banners
+(UIColor *)redBannerColor {
    return UIColorFromRGB(0xac2020);
}


+(UIColor *)blueBannerColor {
    return UIColorFromRGB(0x3c699a);
}


#pragma mark - speedview
+(UIColor *)speedViewDefaultColor {
    return UIColorFromRGB(0x1d2738);
}


+(UIColor *)speedViewHighlightColor {
    return UIColorFromRGB(0x3f6a9a);
}


+(UIColor *)speedViewTitleColor {
    return UIColorFromRGB(0xffffff);
}


+(UIColor *)speedViewPeakPointColor {
    return UIColorFromRGB(0xac2020);
}


+(UIColor *)speedViewBigDividerPointColor {
    return UIColorFromRGB(0xffffff);
}


+(UIColor *)speedViewSmallDividerPointColor {
    return UIColorFromRGB(0x3f6a9a);
}


#pragma mark - history
+(UIColor *)historyCellBackgroundColor {
    return UIColorFromRGB(0x0d1622);
}


+(UIColor *)historySectionTitleTextColor {
    return UIColorFromRGB(0xabb5c0);
}


+(UIColor *)historyCellTextColor {
    return UIColorFromRGB(0xffffff);
}


+(UIColor *)historyDetailVCBackgroundColor {
    return UIColorFromRGB(0x0d1622);
}


#pragma mark conversation
+(UIColor *)conversationInputViewTextViewBackgroundColor {
    return UIColorFromRGB(0x282a41);
}


+(UIColor *)conversationInputViewTextViewCursorColor {
    return UIColorFromRGB(0x0a5dff);
}


+(UIColor *)conversationInputViewTextViewBorderColor {
    return UIColorFromRGB(0x1ABDB3);
}


+(UIColor *)conversationInputViewPlaceholderColor {
    return UIColorFromRGB(0x8d90a6);
}

+(UIColor *)conversationInputViewTextTextColor {
    return [UIColor whiteColor];
}


+(UIColor *)conversationInputViewBackgroundColor {
    return UIColorFromRGB(0x201e2A);
}

@end
