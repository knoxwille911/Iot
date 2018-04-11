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
    return UIColorFromRGB(0x3f5f78);
}


+(UIColor *)tabBarTitleTextColor {
    return UIColorFromRGB(0x9fbfd6);
}


+(UIColor *)tabBarSelectedTitleTextColor {
    return UIColorFromRGB(0xffffff);
}


+(UIColor *)navigationBarBackgroundColor {
    return UIColorFromRGB(0x5b88ac);
}


+(UIColor *)navigationBarTintColor {
    return UIColorFromRGB(0xffffff);
}


+(UIColor *)navigationBarTextColor {
    return UIColorFromRGB(0xffffff);
}


+(UIColor *)navigationBarShadowColor {
    return UIColorFromRGB(0xffffff);
}


#pragma devices list

+(UIColor *)devicesListCellBackgroundColor {
    return UIColorFromRGB(0x5b88ac);
}


+(UIColor *)devicesListTitleTextColor {
    return UIColorFromRGB(0x000000);
}


+(UIColor *)devicesListValueTextColor {
    return UIColorFromRGB(0x000000);
}


+(UIColor *)devicesListSeparatorColor {
    return UIColorFromRGB(0x000000);
}


+(UIColor *)deviceListControllerBackgroundColor {
    return UIColorFromRGB(0x5b88ac);
}


+(UIColor *)devicesListCellTopViewBackgroundColor {
    return UIColorFromRGB(0x9fbfd6);
}


+(UIColor *)devicesListCellBottomViewBackgroundColor {
    return UIColorFromRGB(0x3f5f78);
}

#pragma mark conversation
+(UIColor *)conversationInputViewTextViewBackgroundColor {
    return UIColorFromRGB(0x9fbfd6);
}


+(UIColor *)conversationInputViewTextViewCursorColor {
    return UIColorFromRGB(0x0a5dff);
}


+(UIColor *)conversationInputViewTextViewBorderColor {
    return UIColorFromRGB(0x3f5f78);
}


+(UIColor *)conversationInputViewPlaceholderColor {
    return UIColorFromRGB(0x3f5f78);
}

+(UIColor *)conversationInputViewTextTextColor {
    return [UIColor whiteColor];
}


+(UIColor *)conversationInputViewBackgroundColor {
    //return UIColorFromRGB(0x201e2A);
    return [UIColor clearColor];
}


+(UIColor *)conversationControllerBackgroundColor {
    return UIColorFromRGB(0x5b88ac);
}


+(UIColor *)conversationRecordReflectorViewTextColor {
    return UIColorFromRGB(0xffffff);
}


+(UIColor *)conversationRecordReflectorViewWaveColor {
    return UIColorFromRGB(0x3f5f78);
}


+(UIColor *)conversationRecordReflectorViewBorderColor {
    return UIColorFromRGB(0x3f5f78);
}


+(UIColor *)conversationRecordReflectorViewBackgroundColor {
    return UIColorFromRGB(0x9fbfd6);
}


@end
