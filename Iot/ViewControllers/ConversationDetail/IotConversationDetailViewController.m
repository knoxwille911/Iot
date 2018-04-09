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

@interface IotConversationDetailViewController ()<IotConversationInputViewDelegate> {
    IotConversationInputViewModel *_inputViewModel;
}

@end

@implementation IotConversationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Ella", @"Ella");
    [self addInputBar];
}


-(void)addInputBar {
    
    self.view.backgroundColor = [UIColor conversationControllerBackgroundColor];
    
    _inputViewModel = [[IotConversationInputViewModel alloc] initWithTargetViewController:self delegate:self];
    [_inputViewModel attachToView:self.view];
}


-(void)sendTextMessage:(NSString *)textMessage {
    
}


-(void)sendButtonLongTapBegan {
    [injectorContainer().speechRecognizerController startListening];
}


-(void)sendButtonLongTapEnded {
    [injectorContainer().speechRecognizerController stopListening];
}

@end
