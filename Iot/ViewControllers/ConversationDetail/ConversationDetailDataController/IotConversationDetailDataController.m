//
//  IotConversationDetailDataController.m
//  Iot
//
//  Created by Dmtech on 10.04.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

#import "IotConversationDetailDataController.h"
#import "IotConversationDetailMessageUIInfo.h"
#import "IotConversationAnswerOutDTO.h"
#import "IotConversationDetailBubbleView.h"
#import "IotConversationDetailTableViewWrapperView.h"

@interface IotConversationDetailDataController() {
    
}

@end


@implementation IotConversationDetailDataController

-(instancetype)init {
    if (self = [ super init]) {
        _messages = [NSMutableArray new];
    }
    return self;
}


-(IotConversationDetailMessageUIInfo *)messageInfoForIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > _messages.count) {
        NSAssert(0, @"IotConversationDetailDataController : Somethink wen wrong");
    }
    return _messages[indexPath.row];
}


-(void)addOutgoingMessage:(IotConversationAnswerOutDTO *)message withCompletion:(IotConversationDetailDataControllerAddedMessageHandlerHandler)completion {
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        [_messages addObject:[self conversationBubbleForMessage:message isOutgoing:YES senderID:@"0"]];
        if (self.delegate) {
            [self.delegate countOfMessagesWasChanged];
        }
        if (completion) {
            completion(YES);
        }
    });

}


-(void)addReceivedMessage:(IotConversationAnswerOutDTO *)message withCompletion:(IotConversationDetailDataControllerAddedMessageHandlerHandler)completion {
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        [_messages addObject:[self conversationBubbleForMessage:message isOutgoing:NO senderID:@"Ella"]];
        if (self.delegate) {
            [self.delegate countOfMessagesWasChanged];
        }
        if (completion) {
            completion(YES);
        }
    });
}


-(IotConversationDetailMessageUIInfo *)conversationBubbleForMessage:(IotConversationAnswerOutDTO *)message isOutgoing:(BOOL)isOutgoing senderID:(NSString *)senderID {
    IotConversationDetailMessageUIInfo *messageUIdata = [[IotConversationDetailMessageUIInfo alloc] init];
    if (message.text.length) {
        messageUIdata.message = [[NSAttributedString alloc] initWithString:message.text];
    }
    messageUIdata.isOutgoing = isOutgoing;
    messageUIdata.senderID = senderID;
    messageUIdata.bubbleSize = [IotConversationDetailBubbleView bubbleSizeForData:messageUIdata];
    messageUIdata.messageType = IotChatMessageTypeText;
    
    if (_messages.count) {
        IotConversationDetailMessageUIInfo *previousMessage = _messages.lastObject;
        messageUIdata.showAvatar = YES;
        messageUIdata.showAuthorName = YES;
        if (messageUIdata.isOutgoing) {
            messageUIdata.showAvatar = NO;
            messageUIdata.showAuthorName = NO;
        }
        else if ([previousMessage.senderID isEqualToString:messageUIdata.senderID]) {
            messageUIdata.showAvatar = NO;
            messageUIdata.showAuthorName = NO;
        }
    }
    
    if (!messageUIdata.isOutgoing) {
        if (_messages.count) {
            IotConversationDetailMessageUIInfo *previousMessage = _messages.lastObject;
            if ([previousMessage.senderID isEqualToString:messageUIdata.senderID]) {
                messageUIdata.showAuthorName = YES;
            }
        }
        messageUIdata.authorName = senderID;
    }
    
    return messageUIdata;
}

@end
