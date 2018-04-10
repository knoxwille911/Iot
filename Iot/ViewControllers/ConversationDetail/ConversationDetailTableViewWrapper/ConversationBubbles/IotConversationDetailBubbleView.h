//
//  IotConversationDetailBubbleView.h
//  Iot
//
//  Created by Dmtech on 10.04.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IotConversationDetailMessageUIInfo;

extern CGFloat kIotConversationDetailMaxBubbleWidth;

@interface IotConversationDetailBubbleView : UIView

-(instancetype)initWithData:(IotConversationDetailMessageUIInfo *)params;

-(void)setupViewWithdata:(IotConversationDetailMessageUIInfo *)params;

+(UIEdgeInsets)bubbleViewContentInset;
+(CGSize)bubbleSizeForData:(IotConversationDetailMessageUIInfo *)params;

@end
