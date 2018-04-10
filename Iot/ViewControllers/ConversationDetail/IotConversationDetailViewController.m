//
//  IotConversationDetailViewController.m
//  Iot
//
//  Created by Dmtech on 05.04.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

#import "IotConversationDetailViewController.h"
#import "IotConversationInputViewModel.h"
#import "IotSpeechRecognizer.h"
#import "IotInjectorContainer.h"
#import "UIColor+SPColors.h"
#import "IotConversationDetailTableViewWrapperView.h"
#import "IotConversationAnswerOutDTO.h"
#import "IotConversationInputView.h"

@interface IotConversationDetailViewController ()<IotConversationInputViewDelegate, IotSpeechRecognizerDelegate, UIGestureRecognizerDelegate> {
    IotConversationInputViewModel *_inputViewModel;
    IotConversationDetailTableViewWrapperView *_conversationWrapperView;
}

@end

@implementation IotConversationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *helpBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 7, 20, 20)];
    [helpBtn setBackgroundImage:[UIImage imageNamed:@"question-Ella-icon"] forState:UIControlStateNormal];
    [helpBtn setTitle:@"" forState:UIControlStateNormal];
    [helpBtn addTarget:self action:@selector(onHelpTap) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *notificationBarBtn = [[UIBarButtonItem alloc]initWithCustomView:helpBtn];
    self.navigationItem.rightBarButtonItem = notificationBarBtn;
    
    self.title = NSLocalizedString(@"Ella", @"Ella");
    injectorContainer().speechRecognizerController.delegate = self;
    [self addInputBar];
    [self addConversationView];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    singleTap.delegate = self;
    singleTap.numberOfTapsRequired = 1;
    singleTap.numberOfTouchesRequired = 1;
    [_conversationWrapperView addGestureRecognizer:singleTap];
}


- (void)handleTap:(UITapGestureRecognizer *)tap {
    [_inputViewModel.inputView resignFirstResponder];
}


-(void)onHelpTap {
    [injectorContainer().uiManager showHelloAlertForViewController:self];
}


-(void)addInputBar {
    
    self.view.backgroundColor = [UIColor conversationControllerBackgroundColor];
    
    _inputViewModel = [[IotConversationInputViewModel alloc] initWithTargetViewController:self delegate:self];
    [_inputViewModel attachToView:self.view];
}


-(void)addConversationView {
    _conversationWrapperView = [[IotConversationDetailTableViewWrapperView alloc] initWithFrame:CGRectZero];
    _conversationWrapperView.translatesAutoresizingMaskIntoConstraints = NO;
    _conversationWrapperView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_conversationWrapperView];
    
    [NSLayoutConstraint constraintWithItem:_conversationWrapperView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f].active = YES;
    [NSLayoutConstraint constraintWithItem:_conversationWrapperView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_inputViewModel.inputView attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f].active = YES;
    [NSLayoutConstraint constraintWithItem:_conversationWrapperView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0.0f].active = YES;
    [NSLayoutConstraint constraintWithItem:_conversationWrapperView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0f constant:0.0f].active = YES;
}

#pragma mark IotConversationInputViewDelegate delegate

-(void)sendTextMessage:(NSString *)textMessage {
    IotConversationAnswerOutDTO *conversationDTO = [IotConversationAnswerOutDTO new];
    conversationDTO.text = textMessage;
    [_conversationWrapperView addOutgoingMessage:conversationDTO];
    
    [injectorContainer().serverProvider getConversationAnswerForQuestion:textMessage withCompletion:^(NSArray<MTLModel *> *objects) {
        if (objects.count) {
            IotConversationAnswerOutDTO *answer = (IotConversationAnswerOutDTO *)objects.firstObject;
            [_conversationWrapperView addReceivedMessage:answer];
        }
    }];
}


-(void)sendButtonLongTapBegan {
    [injectorContainer().speechRecognizerController startListening];
}


-(void)sendButtonLongTapEnded {
    [injectorContainer().speechRecognizerController stopListening];
}


-(CGFloat)tabbarHeight {
    return [injectorContainer().uiManager tabbarController].tabBar.frame.size.height;
}

#pragma mark IotSpeechRecognizerDelegate delegate

-(void)recognizedTextUpdated:(NSString *)recognizedText {
    
}

@end
