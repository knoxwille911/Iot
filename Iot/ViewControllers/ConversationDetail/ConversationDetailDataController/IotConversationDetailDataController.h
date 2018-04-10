//
//  IotConversationDetailDataController.h
//  Iot
//
//  Created by Dmtech on 10.04.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IotConversationDetailMessageUIInfo;
@class IotConversationAnswerOutDTO;

@protocol IotConversationDetailDataControllerDelegate

-(void)countOfMessagesWasChanged;

@end


typedef void (^IotConversationDetailDataControllerAddedMessageHandlerHandler) (BOOL result);

@interface IotConversationDetailDataController : NSObject

-(IotConversationDetailMessageUIInfo *)messageInfoForIndexPath:(NSIndexPath *)indexPath;

-(void)addReceivedMessage:(IotConversationAnswerOutDTO *)message withCompletion:(IotConversationDetailDataControllerAddedMessageHandlerHandler)completion;
-(void)addOutgoingMessage:(IotConversationAnswerOutDTO *)message withCompletion:(IotConversationDetailDataControllerAddedMessageHandlerHandler)completion;

@property (nonatomic, strong) NSMutableArray<IotConversationDetailMessageUIInfo *> *messages;
@property (nonatomic, weak) id<IotConversationDetailDataControllerDelegate> delegate;

@end
