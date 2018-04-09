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

@interface IotConversationDetailViewController ()<IotConversationInputViewDelegate, IotSpeechRecognizerDelegate> {
    IotConversationInputViewModel *_inputViewModel;
}

@end

@implementation IotConversationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Ella", @"Ella");
    injectorContainer().speechRecognizerController.delegate = self;
    [self addInputBar];
}


-(void)addInputBar {
    
    self.view.backgroundColor = [UIColor conversationControllerBackgroundColor];
    
    _inputViewModel = [[IotConversationInputViewModel alloc] initWithTargetViewController:self delegate:self];
    [_inputViewModel attachToView:self.view];
}


#pragma mark IotConversationInputViewDelegate delegate

-(void)sendTextMessage:(NSString *)textMessage {
    [injectorContainer().serverProvider getConversationAnswerForQuestion:textMessage withCompletion:^(NSArray<MTLModel *> *objects) {
        
    }];
}


-(void)sendButtonLongTapBegan {
    [injectorContainer().speechRecognizerController startListening];
}


-(void)sendButtonLongTapEnded {
    [injectorContainer().speechRecognizerController stopListening];
}


#pragma mark IotSpeechRecognizerDelegate delegate

-(void)recognizedTextUpdated:(NSString *)recognizedText {
    
}

@end
