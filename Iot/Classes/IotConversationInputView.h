//
//  PCConversationInutView.h
//  PEN
//
//  Created by Dmtech on 08.01.18.
//  Copyright © 2018 DarkMatterAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IotConversationInputViewItemViewModelDelegate

-(void)sendButtonDidTap;
-(void)sendButtonLongTapBegan;
-(void)sendButtonLongTapEnded;
-(void)shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;

@end

@protocol PCInputbarDelegate;
@class HPGrowingTextView;

@interface IotConversationInputView : UIView

-(instancetype)initWithFrame:(CGRect)frame withDelegate:(id<IotConversationInputViewItemViewModelDelegate>)delegate;

@property (nonatomic, assign) id<PCInputbarDelegate> delegate;
@property (nonatomic, strong) HPGrowingTextView *textView;
@property (nonatomic, strong) UIButton *rightButton;

-(void)setLongPressEnabled:(BOOL)enabled;
-(void)resignFirstResponder;
-(void)becomeFirstResponder;

@end



@protocol PCInputbarDelegate <NSObject>

-(void)inputbarDidPressRightButton:(IotConversationInputView *)inputbar;

@end
