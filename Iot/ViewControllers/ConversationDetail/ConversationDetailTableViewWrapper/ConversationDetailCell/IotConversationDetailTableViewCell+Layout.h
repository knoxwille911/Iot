//
//  IotConversationDetailTableViewCell+Layout.h
//  Iot
//
//  Created by Dmtech on 10.04.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

#import "IotConversationDetailTableViewCell.h"

@class IotConversationDetailMessageUIInfo;

extern NSInteger kIotConversationDetailSenderTitleFontSize;

@interface IotConversationDetailTableViewCell(Layout)

-(void)setAvatarLayoutWithData:(IotConversationDetailMessageUIInfo *)messageData;
-(void)setupTimestampWithData:(IotConversationDetailMessageUIInfo *)messageData;
-(void)setupBubbleLayoutWithData:(IotConversationDetailMessageUIInfo *)messageData;

+(CGSize)sizeForMessageData:(IotConversationDetailMessageUIInfo *)messageData bubbleSize:(CGSize)bubbleSize;
+(CGSize)cellTitleForData:(IotConversationDetailMessageUIInfo *)messageData;

@end
