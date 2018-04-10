//
//  IotConversationDetailTableViewCell.h
//  Iot
//
//  Created by Dmtech on 10.04.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IotConversationDetailBubbleView;
@class IotConversationDetailMessageUIInfo;

@interface IotConversationDetailTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) IotConversationDetailBubbleView *bubble;
@property (nonatomic, strong) UIImageView *avatarView;


-(void)setMessageData:(IotConversationDetailMessageUIInfo *)messageData;

+(UIEdgeInsets)avatarInset;
+(UIEdgeInsets)bubbleFromAvatarInset;

+(UIEdgeInsets)titleInsetWithAvatar;
+(UIEdgeInsets)titleInsetWithoutAvatar;
+(UIEdgeInsets)stateViewInsetWithName;
+(UIEdgeInsets)stateViewInsetWithoutName;

+(CGFloat)titleHeight;

+(UIEdgeInsets)bubbleInset;

+(CGSize)avatarSize;

+(CGFloat)cellWidth;

+(CGFloat)bubbleTopOffsetWithData:(IotConversationDetailMessageUIInfo *)messageData;


@end
