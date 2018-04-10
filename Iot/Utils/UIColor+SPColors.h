//
//  UIColor+PCColors.h
//  PEN
//
//  A UIColor category to encapsulate all used colors in PEN
//
//  Created by João Carreira on 03/03/16.
//  Copyright © 2016 DarkMatterAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (SPColors)

#pragma mark - common colors

+(UIColor *)tabBarBackgroundColor;
+(UIColor *)tabBarTitleTextColor;
+(UIColor *)tabBarSelectedTitleTextColor;
+(UIColor *)navigationBarBackgroundColor;
+(UIColor *)navigationBarTintColor;
+(UIColor *)navigationBarTextColor;
+(UIColor *)navigationBarShadowColor;

#pragma devices list

+(UIColor *)devicesListCellBackgroundColor;
+(UIColor *)devicesListTitleTextColor;
+(UIColor *)devicesListValueTextColor;
+(UIColor *)devicesListSeparatorColor;
+(UIColor *)deviceListControllerBackgroundColor;
+(UIColor *)devicesListCellTopViewBackgroundColor;
+(UIColor *)devicesListCellBottomViewBackgroundColor;

#pragma conversation
+(UIColor *)conversationInputViewTextViewBackgroundColor;
+(UIColor *)conversationInputViewTextViewCursorColor;
+(UIColor *)conversationInputViewTextViewBorderColor;
+(UIColor *)conversationInputViewTextTextColor;
+(UIColor *)conversationInputViewBackgroundColor;
+(UIColor *)conversationInputViewPlaceholderColor;
+(UIColor *)conversationInputViewGalleryCellOverlayColor;
+(UIColor *)conversationControllerBackgroundColor;
+(UIColor *)conversationDetailOutgoindBubbleBackgroundColor;
+(UIColor *)conversationDetailIncomingBubbleBackgroundColor;
+(UIColor *)conversationDetailSenderNameTitleColor;

@end
