//
//  IotSpeechRecognizer.m
//  Iot
//
//  Created by Dmtech on 06.04.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

#import "IotSpeechRecognizer.h"
#import <Speech/Speech.h>
#import <Accelerate/Accelerate.h>

static const CGFloat kAudioFilterValue = 0.3f;
static const CGFloat kMinAudioPowerValue = -100.f;

@interface IotSpeechRecognizer () <SFSpeechRecognizerDelegate> {
    SFSpeechRecognizer *_speechRecognizer;
    SFSpeechAudioBufferRecognitionRequest *_recognitionRequest;
    SFSpeechRecognitionTask *_recognitionTask;
    AVAudioEngine *_audioEngine;
    
    CGFloat _audioPower;
}

@end

@implementation IotSpeechRecognizer

@synthesize delegate = _delegate;

- (instancetype)initWithInjection:(id<IotSpeechRecognizerInjection>)injection {
    if (self = [super init]) {
        _speechRecognizer = [[SFSpeechRecognizer alloc] initWithLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_EN"]];
        
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
    _recognitionRequest.shouldReportPartialResults = NO;
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
        
        if (self.delegate) {
            [self.delegate recognizedTextUpdated:result.bestTranscription.formattedString];
        }
    }];
    
    // Sets the recording format
    AVAudioFormat *recordingFormat = [inputNode outputFormatForBus:0];
    
    [inputNode installTapOnBus:0 bufferSize:1024 format:recordingFormat block:^(AVAudioPCMBuffer * _Nonnull buffer, AVAudioTime * _Nonnull when) {
        [_recognitionRequest appendAudioPCMBuffer:buffer];

        [buffer setFrameLength:1024];
        UInt32 inNumberFrames = buffer.frameLength;

        if(buffer.format.channelCount > 0) {
            Float32* samples = (Float32*)buffer.floatChannelData[0];
            Float32 avgValue = 0;

            vDSP_meamgv((Float32*)samples, 1, &avgValue, inNumberFrames);
            _audioPower = (kAudioFilterValue*((avgValue==0)?kMinAudioPowerValue:20.0*log10f(avgValue))) + ((1-kAudioFilterValue)*_audioPower) ;
        }
        
        if (self.delegate) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate recordingAudioPowerChanged:[self normalizedPowerValue:_audioPower]];
            });
        }
    }];
    
    // Starts the audio engine, i.e. it starts listening.
    [_audioEngine prepare];
    [_audioEngine startAndReturnError:&error];
    
    NSLog(@"Say Something, I'm listening");
}


- (CGFloat)normalizedPowerValue:(CGFloat)value {
    CGFloat normalizedValue = 1 - (value * 2 / kMinAudioPowerValue);
    return normalizedValue;
}


-(void)stopListening {
    [_audioEngine stop];
    [_recognitionRequest endAudio];
}

@end
