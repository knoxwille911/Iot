//
//  IotConversationInputViewModel.h
//  PEN
//
//  Created by Dmtech on 11.01.18.
//  Copyright © 2018 DarkMatterAB. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IotConversationInputView;
@class PCConversationMessageModel;

@protocol IotConversationInputViewDelegate

-(void)sendTextMessage:(NSString *)textMessage;
-(void)sendButtonLongTapBegan;
-(void)sendButtonLongTapEnded;

@end


@interface IotConversationInputViewModel : NSObject

-(instancetype)initWithTargetViewController:(UIViewController *)targetViewController delegate:(id<IotConversationInputViewDelegate>)delegate;

@property (nonatomic, strong) IotConversationInputView *inputView;

-(void)attachToView:(UIView *)superView;

@end
