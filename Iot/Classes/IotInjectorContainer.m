//
//  SPInjectorContainer.m
//  SpeedTest
//
//  Created by Dmtech on 19.02.18.
//  Copyright © 2018 Dmtech. All rights reserved.
//

#import "IotInjectorContainer.h"

@implementation IotInjectorContainer

- (id<IotUIManagerProtocol>)uiManager {
    static id<IotUIManagerProtocol> uiManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        uiManager = [[IotUIManager alloc] initWithInjection:self];
    });
    return uiManager;
}


- (id<IotServerProviderProtocol>)serverProvider {
    static id<IotServerProviderProtocol> serverProvider = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        serverProvider = [[IotServerProvider alloc] initWithInjection:self];
    });
    return serverProvider;
}


- (id<IotNetworkControllerProtocol>)networkController {
    static id<IotNetworkControllerProtocol> networkController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkController = [[IotNetworkController alloc] initWithInjection:self];
    });
    return networkController;
}


- (id<IotSpeechRecognizerProtocol>)speechRecognizerController; {
    static id<IotSpeechRecognizerProtocol> speechRecognizer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        speechRecognizer = [[IotSpeechRecognizer alloc] initWithInjection:self];
    });
    return speechRecognizer;
}


@end

IotInjectorContainer *injectorContainer() {
    static IotInjectorContainer * injectorContainer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        injectorContainer = [[IotInjectorContainer alloc] init];
        
    });
    return injectorContainer;
}
