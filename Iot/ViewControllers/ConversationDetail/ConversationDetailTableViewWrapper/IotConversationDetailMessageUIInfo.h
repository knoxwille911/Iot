//
//  IotConversationDetailMessageUIInfo.h
//  Iot
//
//  Created by Dmtech on 10.04.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, IotConversationDetailMessageType) {
    IotChatMessageTypeText
};

@interface IotConversationDetailMessageUIInfo : NSObject

@property(nonatomic,assign) CGSize bubbleSize;
@property(nonatomic,assign) CGSize cellTitleSize;

@property(nonatomic,assign) BOOL showAuthorName;
@property(nonatomic,assign) BOOL showTimeStamp;
@property(nonatomic,assign) BOOL showAvatar;

@property(nonatomic,assign) BOOL isHiddenAvatar;
@property(nonatomic,assign) BOOL isOutgoing;


@property(nonatomic, strong) NSString *timestampStr;
@property(nonatomic, strong) NSString *senderID;


@property(nonatomic,strong) NSString *authorName;

@property(nonatomic,retain) NSAttributedString *message;

@property(nonatomic,assign) IotConversationDetailMessageType messageType;

-(NSString *)messageTitleLabel;

@end
