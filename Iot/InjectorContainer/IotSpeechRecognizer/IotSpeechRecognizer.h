//
//  IotSpeechRecognizer.h
//  Iot
//
//  Created by Dmtech on 06.04.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IotSpeechRecognizerProtocol.h"

@protocol IotSpeechRecognizerInjection<NSObject>


@end

@interface IotSpeechRecognizer : NSObject<IotSpeechRecognizerProtocol>

- (instancetype)init __attribute__((unavailable("dont use init, use initWithInjection")));

- (instancetype)initWithInjection:(id<IotSpeechRecognizerInjection>)injection;

@end
