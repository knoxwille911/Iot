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
#import "IotRecordReflectorViewer.h"
#import "IotRecordReflectorView.h"

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


#pragma mark - IotConversationInputViewDelegate

-(void)sendTextMessage:(NSString *)textMessage {
    [injectorContainer().serverProvider getConversationAnswerForQuestion:textMessage withCompletion:^(NSArray<MTLModel *> *objects) {
        
    }];
}


-(void)sendButtonLongTapBegan {
    [IotRecordReflectorViewer.sharedInstance showRecordReflectorViewInViewIfNeeded:self.view];
    [injectorContainer().speechRecognizerController startListening];
}


-(void)sendButtonLongTapEnded {
    [IotRecordReflectorViewer.sharedInstance hideReflectorView];
    [injectorContainer().speechRecognizerController stopListening];
}


#pragma mark - IotSpeechRecognizerDelegate

-(void)recognizedTextUpdated:(NSString *)recognizedText {
    [self sendTextMessage:recognizedText];
}


-(void)recordingAudioPowerChanged:(CGFloat)audioPower {
    [IotRecordReflectorViewer.sharedInstance.reflectorView updateWaveWithValue:audioPower];
}

@end
