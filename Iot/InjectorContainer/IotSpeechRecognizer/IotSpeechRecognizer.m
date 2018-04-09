//
//  IotSpeechRecognizer.m
//  Iot
//
//  Created by Dmtech on 06.04.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

#import "IotSpeechRecognizer.h"
#import <Speech/Speech.h>

@interface IotSpeechRecognizer ()<SFSpeechRecognizerDelegate> {
    SFSpeechRecognizer *_speechRecognizer;
    SFSpeechAudioBufferRecognitionRequest *_recognitionRequest;
    SFSpeechRecognitionTask *_recognitionTask;
    AVAudioEngine *_audioEngine;
}

@end

@implementation IotSpeechRecognizer

- (instancetype)initWithInjection:(id<IotSpeechRecognizerInjection>)injection {
    if (self = [super init]) {
        _speechRecognizer = [[SFSpeechRecognizer alloc] initWithLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
        
        // Set speech recognizer delegate
        _speechRecognizer.delegate = self;
        
        // Request the authorization to make sure the user is asked for permission so you can
        // get an authorized response, also remember to change the .plist file, check the repo's
        // readme file or this project's info.plist
        [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
            switch (status) {
                case SFSpeechRecognizerAuthorizationStatusAuthorized:
                    NSLog(@"Authorized");
                    break;
                case SFSpeechRecognizerAuthorizationStatusDenied:
                    NSLog(@"Denied");
                    break;
                case SFSpeechRecognizerAuthorizationStatusNotDetermined:
                    NSLog(@"Not Determined");
                    break;
                case SFSpeechRecognizerAuthorizationStatusRestricted:
                    NSLog(@"Restricted");
                    break;
                default:
                    break;
            }
        }];
    }
    return self;
}


- (void)startListening {
    
    // Initialize the AV_audioEngine
    _audioEngine = [[AVAudioEngine alloc] init];
    
    // Make sure there's not a recognition task already running
    if (_recognitionTask) {
        [_recognitionTask cancel];
        _recognitionTask = nil;
    }
    
    // Starts an AVAudio Session
    NSError *error;
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryRecord error:&error];
    [audioSession setActive:YES withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:&error];
    
    // Starts a recognition process, in the block it logs the input or stops the audio
    // process if there's an error.
    _recognitionRequest = [[SFSpeechAudioBufferRecognitionRequest alloc] init];
    AVAudioInputNode *inputNode = _audioEngine.inputNode;
    _recognitionRequest.shouldReportPartialResults = YES;
    _recognitionTask = [_speechRecognizer recognitionTaskWithRequest:_recognitionRequest resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        BOOL isFinal = NO;
        if (result) {
            // Whatever you say in the microphone after pressing the button should be being logged
            // in the console.
            NSLog(@"RESULT:%@",result.bestTranscription.formattedString);
            isFinal = !result.isFinal;
        }
        if (error) {
            [_audioEngine stop];
            [inputNode removeTapOnBus:0];
            _recognitionRequest = nil;
            _recognitionTask = nil;
        }
    }];
    
    // Sets the recording format
    AVAudioFormat *recordingFormat = [inputNode outputFormatForBus:0];
    [inputNode installTapOnBus:0 bufferSize:1024 format:recordingFormat block:^(AVAudioPCMBuffer * _Nonnull buffer, AVAudioTime * _Nonnull when) {
        [_recognitionRequest appendAudioPCMBuffer:buffer];
    }];
    
    // Starts the audio engine, i.e. it starts listening.
    [_audioEngine prepare];
    [_audioEngine startAndReturnError:&error];
    NSLog(@"Say Something, I'm listening");
}


-(void)stopListening {
    [_audioEngine stop];
    [_recognitionRequest endAudio];
}

@end
