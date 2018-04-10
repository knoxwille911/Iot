//
//  IotConversationDetailTableViewCell.m
//  Iot
//
//  Created by Dmtech on 10.04.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

#import "IotConversationDetailTableViewCell.h"
#import "IotConversationDetailBubbleView.h"
#import "IotConversationDetailTableViewCell+Layout.h"
#import "IotConversationDetailMessageUIInfo.h"

@implementation IotConversationDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


-(void)setMessageData:(IotConversationDetailMessageUIInfo *)messageData {
    [self setAvatarLayoutWithData:messageData];
    [self setupBubbleLayoutWithData:messageData];
    [self setupTimestampWithData:messageData];
}


+(CGFloat)cellWidth {
    return [UIScreen mainScreen].bounds.size.width;
}


-(void)prepareForReuse {
    [super prepareForReuse];
    
    [self.avatarView removeFromSuperview];
    [self.timeLabel removeFromSuperview];
    [self.bubble removeFromSuperview];
    self.timeLabel = nil;
    self.avatarView = nil;
    self.bubble = nil;
}


+(UIEdgeInsets)avatarInset {
    return UIEdgeInsetsMake(0, 15, 10, 0);
}

+(UIEdgeInsets)bubbleFromAvatarInset {
    return UIEdgeInsetsMake(0, 3, 10, 13);
}


+(UIEdgeInsets)stateViewInsetWithName {
    return UIEdgeInsetsMake(0, 0, 0, 5);
}


+(UIEdgeInsets)stateViewInsetWithoutName {
    return UIEdgeInsetsMake(2, 0, 0, 3);
}


+(UIEdgeInsets)titleInsetWithAvatar {
    return UIEdgeInsetsMake(0, 5, 0, 0);
}



+(UIEdgeInsets)titleInsetWithoutAvatar {
    return UIEdgeInsetsMake(1, 8, 0, 8);
}


+(CGFloat)titleHeight {
    return [UIFont systemFontOfSize:kIotConversationDetailSenderTitleFontSize].lineHeight;
}


+(UIEdgeInsets)bubbleInset {
    return UIEdgeInsetsMake(5, 8, 5, 0);
}


+(CGSize)avatarSize {
    return CGSizeMake(44, 44);
}


+(CGFloat)bubbleTopOffsetWithData:(IotConversationDetailMessageUIInfo *)messageData {
    return messageData.showTimeStamp ? ([IotConversationDetailTableViewCell titleInsetWithAvatar].top + [IotConversationDetailTableViewCell titleHeight] + [IotConversationDetailTableViewCell bubbleInset].top) : [IotConversationDetailTableViewCell bubbleInset].top;
}

@end
