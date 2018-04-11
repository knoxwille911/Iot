//
//  PCConversationInutView.m
//  PEN
//
//  Created by Dmtech on 08.01.18.
//  Copyright © 2018 DarkMatterAB. All rights reserved.
//

#import "IotConversationInputView.h"
#import "HPGrowingTextView.h"
#import "UIColor+SPColors.h"
#import "UITextView+Placeholder.h"

static NSString *kConversationSendButtonImageName = @"Button-sent";
static NSString *kConversationSendButtonImageNameRecognition = @"Button-speech-recognition";

static const UIEdgeInsets kConversationInpuViewTextViewInset = {5, 5, -5, 5};

static const UIEdgeInsets kConversationInpuViewSendButtonInset = {0, -5, 0, -5};
static const UIEdgeInsets kConversationInpuViewEmoticonButtonInset = {0, 0, -5, -5};


@interface IotConversationInputView() <HPGrowingTextViewDelegate> {
    NSMutableArray<NSLayoutConstraint *> *_bottomConstraints;
    UILongPressGestureRecognizer *_longPress;
}

@property (weak, nonatomic) id<IotConversationInputViewItemViewModelDelegate> inputViewdelegate;
@end

@implementation IotConversationInputView

-(instancetype)initWithFrame:(CGRect)frame withDelegate:(id<IotConversationInputViewItemViewModelDelegate>)delegate {
    if (self = [super initWithFrame:frame]) {
        _inputViewdelegate = delegate;
        
        [self setupView];
        [self addContent];
        
        _bottomConstraints = [NSMutableArray new];
        
        [self setupBottomConstraints];
    }
    return self;
}


-(void)setupView {
    self.backgroundColor = [UIColor clearColor];
}


-(void)addContent {
    [self addRightButton];
    [self addTextView];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
}


-(void)addTextView {

    _textView = [[HPGrowingTextView alloc] initWithFrame:CGRectZero];
    _textView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_textView];
    
    [NSLayoutConstraint constraintWithItem:_textView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0f constant:kConversationInpuViewTextViewInset.left].active = YES;
    [NSLayoutConstraint constraintWithItem:_textView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.rightButton attribute:NSLayoutAttributeLeft multiplier:1.0f constant:kConversationInpuViewSendButtonInset.left].active = YES;
    [NSLayoutConstraint constraintWithItem:_textView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0f constant:kConversationInpuViewTextViewInset.top].active = YES;

    
    _textView.isScrollable = NO;
    _textView.contentInset = kConversationInpuViewTextViewInset;
    _textView.internalTextView.keyboardAppearance = UIKeyboardAppearanceDark;
    _textView.minNumberOfLines = 1;
    _textView.maxNumberOfLines = 4;
    _textView.layer.cornerRadius = (CGRectGetHeight(self.frame) - kConversationInpuViewTextViewInset.top + kConversationInpuViewTextViewInset.bottom)  / 2;
    _textView.clipsToBounds = YES;
    _textView.animateHeightChange = NO;
    
    _textView.returnKeyType = UIReturnKeyGo;
    _textView.font = [UIFont systemFontOfSize:15.0f];
    _textView.delegate = self;
    _textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);

    _textView.keyboardType = UIKeyboardTypeDefault;
    _textView.returnKeyType = UIReturnKeyDefault;
    _textView.enablesReturnKeyAutomatically = YES;
    //textView.scrollIndicatorInsets = UIEdgeInsetsMake(0.0, -1.0, 0.0, 1.0);
    //textView.textContainerInset = UIEdgeInsetsMake(8.0, 4.0, 8.0, 0.0);
    _textView.layer.borderWidth = 1;
    _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    _textView.internalTextView.placeholder = NSLocalizedString(@"Type a message...", @"Type a message...");
    
    _textView.layer.borderColor =  [UIColor conversationInputViewTextViewBorderColor].CGColor;
    _textView.backgroundColor = [UIColor conversationInputViewTextViewBackgroundColor];
    _textView.internalTextView.tintColor = [UIColor conversationInputViewTextViewCursorColor];
    _textView.textColor = [UIColor conversationInputViewTextTextColor];
    _textView.internalTextView.placeholderColor = [UIColor conversationInputViewPlaceholderColor];
}


- (void)setLongPressEnabled:(BOOL)enabled {
    _longPress.enabled = enabled;
}


-(void)addRightButton {
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.rightButton setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[UIColor clearColor] forState:UIControlStateSelected];
    [self.rightButton setImage:[UIImage imageNamed:kConversationSendButtonImageNameRecognition] forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(didPressRightButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    
    [self.rightButton addGestureRecognizer:_longPress];
    
    self.rightButton.enabled = YES;
    [self addSubview:self.rightButton];
    
    [NSLayoutConstraint constraintWithItem:self.rightButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0f constant:kConversationInpuViewSendButtonInset.right].active = YES;
    [NSLayoutConstraint constraintWithItem:self.rightButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:CGRectGetHeight(self.frame)].active = YES;
}


-(void)setupBottomConstraints {
    [_bottomConstraints enumerateObjectsUsingBlock:^(NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.active = NO;
    }];
    [_bottomConstraints removeAllObjects];
    
    [_bottomConstraints addObject:[NSLayoutConstraint constraintWithItem:self.rightButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0]];
    [_bottomConstraints addObject:[NSLayoutConstraint constraintWithItem:_textView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:kConversationInpuViewTextViewInset.bottom]];
    [_bottomConstraints enumerateObjectsUsingBlock:^(NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.active = YES;
    }];
}


-(void)becomeFirstResponder {
    [_textView becomeFirstResponder];
}


-(void)resignFirstResponder {
    [_textView resignFirstResponder];
}


-(NSString *)text
{
    return _textView.text;
}


#pragma mark - Delegate

-(void)didPressRightButton:(UIButton *)sender {
    if (_inputViewdelegate) {
        [_inputViewdelegate sendButtonDidTap];
    }
}


- (void)longPress:(UILongPressGestureRecognizer*)gesture {
    if ( gesture.state == UIGestureRecognizerStateEnded ) {
        if (_inputViewdelegate) {
            [_inputViewdelegate sendButtonLongTapEnded];
        }
    }
    if ( gesture.state == UIGestureRecognizerStateBegan ) {
        if (_inputViewdelegate) {
            [_inputViewdelegate sendButtonLongTapBegan];
        }
    }
}


#pragma mark - TextViewDelegate

-(void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height {
    float diff = (growingTextView.frame.size.height - height);
    
    
    CGRect r = self.frame;
    r.size.height -= diff;
    r.origin.y += diff;
    self.frame = r;
    [self setupBottomConstraints];
    [UIView animateWithDuration:0.3 animations:^{

    } completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:0.3 animations:^{
        
    }];
    
    
//    if (self.delegate && [self.delegate respondsToSelector:@selector(inputbarDidChangeHeight:)]) {
//        [self.delegate inputbarDidChangeHeight:self.frame.size.height];
//    }
}


-(void)growingTextViewDidBeginEditing:(HPGrowingTextView *)growingTextView {
//    if (self.delegate && [self.delegate respondsToSelector:@selector(inputbarDidBecomeFirstResponder:)])
//    {
////        [self.delegate inputbarDidBecomeFirstResponder:self];
//    }
}


- (void)growingTextView:(HPGrowingTextView *)growingTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (_inputViewdelegate) {
        [_inputViewdelegate shouldChangeTextInRange:range replacementText:text];
    }
}

- (void)growingTextViewDidChange:(HPGrowingTextView *)growingTextView {
    NSString *text = [growingTextView.text stringByReplacingOccurrencesOfString:@" " withString:@""];

}

@end

