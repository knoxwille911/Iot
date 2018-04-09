//
//  IotSpeechRecognizerProtocol.h
//  Iot
//
//  Created by Dmtech on 06.04.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IotSpeechRecognizerProtocol<NSObject>

-(void)startListening;
-(void)stopListening;

@end
