//
//  IotConversationDetailTableViewCell+Layout.m
//  Iot
//
//  Created by Dmtech on 10.04.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

#import "IotConversationDetailTableViewCell+Layout.h"
#import "IotConversationDetailMessageUIInfo.h"
#import "UIColor+SPColors.h"
#import "IotConversationDetailBubbleView.h"
#import "IotConversationDetailTextBubbleView.h"

NSInteger kIotConversationDetailSenderTitleFontSize = 10;

@implementation IotConversationDetailTableViewCell(Layout)

-(void)setAvatarLayoutWithData:(IotConversationDetailMessageUIInfo *)messageData {
    if (!messageData.showAvatar) {
        return;
    }
    self.avatarView = [UIImageView new];
    [self.contentView addSubview:self.avatarView];
    
    CGFloat xAvatarCoordinate = messageData.isOutgoing ? [IotConversationDetailTableViewCell cellWidth] - [IotConversationDetailTableViewCell avatarInset].left - [IotConversationDetailTableViewCell avatarSize].width : [IotConversationDetailTableViewCell avatarInset].left;
    
    self.avatarView.frame = CGRectMake(xAvatarCoordinate,
                                       0,
                                       [IotConversationDetailTableViewCell avatarSize].width,
                                       [IotConversationDetailTableViewCell avatarSize].height);
    
    self.avatarView.layer.cornerRadius = [IotConversationDetailTableViewCell avatarSize].height / 2;
    self.avatarView.layer.masksToBounds = YES;
    self.avatarView.image = [UIImage imageNamed:@"PeNelopa"];
}


-(void)setupTimestampWithData:(IotConversationDetailMessageUIInfo *)messageData {
    if (!messageData.showTimeStamp && !messageData.showAuthorName) {
        return;
    }
    CGFloat xTimeStampCoordinate = 0;
    UIEdgeInsets titleInset = messageData.showAvatar ? [IotConversationDetailTableViewCell titleInsetWithAvatar] : [IotConversationDetailTableViewCell titleInsetWithoutAvatar];
    
    if (messageData.isOutgoing) {
        xTimeStampCoordinate = [IotConversationDetailTableViewCell cellWidth] - messageData.cellTitleSize.width - [IotConversationDetailTableViewCell bubbleFromAvatarInset].right;
    }
    else {
        xTimeStampCoordinate = titleInset.left;
        if (messageData.showAvatar) {
            xTimeStampCoordinate += [IotConversationDetailTableViewCell avatarInset].left + [IotConversationDetailTableViewCell avatarSize].width;
        }
    }
    
    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(xTimeStampCoordinate,
                                                              [IotConversationDetailTableViewCell titleInsetWithAvatar].top,
                                                              messageData.cellTitleSize.width,
                                                              messageData.cellTitleSize.height)];
    
    self.timeLabel.text = [messageData messageTitleLabel];
    self.timeLabel.textAlignment = NSTextAlignmentLeft;
    self.timeLabel.font = [UIFont systemFontOfSize:kIotConversationDetailSenderTitleFontSize];
    self.timeLabel.textColor = [UIColor conversationDetailSenderNameTitleColor];
    [self.contentView addSubview:self.timeLabel];
}


-(void)setupBubbleLayoutWithData:(IotConversationDetailMessageUIInfo *)messageData {
    IotConversationDetailBubbleView *bubble = nil;
    CGFloat xBubbleCoordinate = 0;
    if (messageData.isOutgoing) {
        xBubbleCoordinate = [IotConversationDetailTableViewCell cellWidth] - [IotConversationDetailTableViewCell bubbleFromAvatarInset].right;
    }
    else {
        xBubbleCoordinate = [IotConversationDetailTableViewCell avatarInset].left + [IotConversationDetailTableViewCell avatarSize].width + [IotConversationDetailTableViewCell bubbleFromAvatarInset].left;
    }
    switch (messageData.messageType) {
        case IotChatMessageTypeText:
            bubble = [[IotConversationDetailTextBubbleView alloc] initWithData:messageData];
            xBubbleCoordinate -= messageData.isOutgoing ? CGRectGetWidth(bubble.frame) : 0;
            break;
        default:
            break;
    }
    self.bubble = bubble;
    self.bubble.frame = CGRectMake(xBubbleCoordinate,
                                   [IotConversationDetailTableViewCell bubbleTopOffsetWithData:messageData],
                                   CGRectGetWidth(bubble.frame),
                                   CGRectGetHeight(bubble.frame));
    
    [self.contentView addSubview:bubble];
}


+(CGSize)cellTitleForData:(IotConversationDetailMessageUIInfo *)messageData {
    if (![messageData messageTitleLabel].length) {
        return CGSizeZero;
    }
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:messageData.messageTitleLabel];
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:kIotConversationDetailSenderTitleFontSize]};
    [attrString addAttributes:attributes range:NSMakeRange(0, messageData.messageTitleLabel.length)];
    CGRect rect = [attrString boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    return CGSizeMake(ceil(rect.size.width), ceil(rect.size.height));
}

@end
