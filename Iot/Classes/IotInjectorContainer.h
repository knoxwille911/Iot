//
//  SPInjectorContainer.h
//  SpeedTest
//
//  Created by Dmtech on 19.02.18.
//  Copyright © 2018 Dmtech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IotUIManager.h"
#import "IotServerProvider.h"
#import "IotNetworkController.h"
#import "IotSpeechRecognizer.h"

@interface IotInjectorContainer : NSObject<IotUIManagerInjection,
                                           IotNetworkControllerInjection,
                                           IotServerProviderInjection,
                                           IotSpeechRecognizerInjection>

- (id<IotUIManagerProtocol>)uiManager;
- (id<IotServerProviderProtocol>)serverProvider;
- (id<IotNetworkControllerProtocol>)networkController;
- (id<IotSpeechRecognizerProtocol>)speechRecognizerController;

@end

IotInjectorContainer *injectorContainer();
