//
//  IotConversationDetailTableViewWrapperView.h
//  Iot
//
//  Created by Dmtech on 10.04.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IotConversationAnswerOutDTO.h"

@interface IotConversationDetailTableViewWrapperView : UIView

-(void)addReceivedMessage:(IotConversationAnswerOutDTO *)message;
-(void)addOutgoingMessage:(IotConversationAnswerOutDTO *)message;

@end
