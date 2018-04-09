//
//  IotConversationInputViewModel.m
//  PEN
//
//  Created by Dmtech on 11.01.18.
//  Copyright © 2018 DarkMatterAB. All rights reserved.
//

#import "IotConversationInputViewModel.h"
#import "IotConversationInputView.h"
#import "HPGrowingTextView.h"

static CGFloat kConversationInputViewHeight = 44;

@interface IotConversationInputViewModel()<IotConversationInputViewItemViewModelDelegate> {

    BOOL _ignoreAutocomplete;
}

@property (nonatomic, weak) UIViewController *targetViewController;
@property (nonatomic, weak) id<IotConversationInputViewDelegate> delegate;

@property (nonatomic, assign) NSInteger selectionAssetsCount;
@property (nonatomic, assign) BOOL rightButtonEnable;
@property (nonatomic, assign) BOOL sendButtonEnable;

@property (nonatomic, strong) NSMutableAttributedString *messageText;

@property (nonatomic, assign) CGRect inputViewRect;

@end

@implementation IotConversationInputViewModel

-(instancetype)initWithTargetViewController:(UIViewController *)targetViewController delegate:(id<IotConversationInputViewDelegate>)delegate {
    if (self = [super init]) {
        _targetViewController = targetViewController;
        _delegate = delegate;
        
        self.messageText = [[NSMutableAttributedString alloc] init];
        self.sendButtonEnable = YES;
        [self setupView];
        [self subscibeToNotifications];
    }
    return self;
}


-(void)subscibeToNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    __weak IotConversationInputViewModel *weakSelf = self;

    RAC(self, inputView.rightButton.enabled) = [RACSignal combineLatest:@[RACObserve(self, selectionAssetsCount),
                                                                          RACObserve(self, messageText),
                                                                          RACObserve(self, sendButtonEnable)]
                                                                 reduce:^(NSNumber *selectedAssetsCount, NSAttributedString *inputText, NSNumber *sendButtonEnable) {
                                                                     return @(inputText.length > 0 && sendButtonEnable.boolValue);
                                                                 }];
}


-(void)setupView {
    CGRect inputViewFrame = CGRectMake(0,
                                       CGRectGetHeight(_targetViewController.view.frame) - kConversationInputViewHeight,
                                       CGRectGetWidth(_targetViewController.view.frame),
                                       kConversationInputViewHeight);
    self.inputView = [[IotConversationInputView alloc] initWithFrame:inputViewFrame withDelegate:self];
}


-(void)attachToView:(UIView *)superView {
    [_targetViewController.view addSubview:self.inputView];
}


#pragma mark input view delegate

-(void)shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (!text.length) {
        NSMutableAttributedString *newString = [[NSMutableAttributedString alloc] initWithAttributedString:self.messageText];
        [newString replaceCharactersInRange:range withString:text];
        self.messageText = newString;
    }
    else {
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text];
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, string.length)];
        [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0] range:NSMakeRange(0, string.length)];
        NSMutableAttributedString *newString = [[NSMutableAttributedString alloc] initWithAttributedString:self.messageText];
        [newString replaceCharactersInRange:range withString:text];
        self.messageText = newString;
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
    }
}


-(void)setMessageText:(NSMutableAttributedString *)messageText {
    _messageText = messageText;
}


-(void)openKeyboard {
    self.inputView.textView.internalTextView.inputView = nil;
    [self.inputView.textView.internalTextView reloadInputViews];
}


-(void)sendButtonDidTap {
    if (_delegate) {
        self.sendButtonEnable = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.sendButtonEnable = YES;
        });
        if (self.messageText.length) {
            [self.delegate sendTextMessage:self.inputView.textView.text];
//            [_delegate sendTextMessage:[_injection.emoticonsManager detectEmoticonsByByHashAndReplaceToCodes:self.messageText]];
            self.messageText = nil;
            self.messageText = [[NSMutableAttributedString alloc] init];
            self.inputView.textView.text = nil;
            self.inputView.textView.internalTextView.text = nil;
            [self.inputView.textView refreshHeight];
        }
    }
}


-(void)sendButtonLongTapBegan {
    [self.delegate sendButtonLongTapBegan];
}


-(void)sendButtonLongTapEnded {
    [self.delegate sendButtonLongTapEnded];
}


#pragma mark keyboad notifications

-(void) keyboardWillShow:(NSNotification *)note{
    // get keyboard size and loctaion
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // Need to translate the bounds to account for rotation.
    keyboardBounds = [_targetViewController.view convertRect:keyboardBounds toView:nil];
    
    // get a rect for the textView frame
    CGRect containerFrame = self.inputView.frame;
    containerFrame.origin.y = _targetViewController.view.bounds.size.height - (keyboardBounds.size.height + containerFrame.size.height);
    // animations settings
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
    // set views with new info
    self.inputView.frame = containerFrame;
    
    // commit animations
    [UIView commitAnimations];
}

-(void) keyboardWillHide:(NSNotification *)note{
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // get a rect for the textView frame
    CGRect containerFrame = self.inputView.frame;
    containerFrame.origin.y = _targetViewController.view.bounds.size.height - containerFrame.size.height;
    
    // animations settings
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
    // set views with new info
    self.inputView.frame = containerFrame;
    
    // commit animations
    [UIView commitAnimations];
}

@end
