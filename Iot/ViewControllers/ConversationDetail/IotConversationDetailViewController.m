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

@interface IotConversationDetailViewController ()<IotConversationInputViewDelegate> {
    IotConversationInputViewModel *_inputViewModel;
}

@end

@implementation IotConversationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addInputBar];
}


-(void)addInputBar {
    _inputViewModel = [[IotConversationInputViewModel alloc] initWithTargetViewController:self delegate:self];
    [_inputViewModel attachToView:self.view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
