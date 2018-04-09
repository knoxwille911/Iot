//
//  IotServerProvider.h
//  SpeedTest
//
//  Created by Dmtech on 19.03.18.
//  Copyright © 2018 Dmtech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IotServerProviderProtocol.h"

@protocol IotNetworkControllerProtocol;

@protocol IotServerProviderInjection<NSObject>

- (id<IotNetworkControllerProtocol>)networkController;

@end


@interface IotServerProvider : NSObject<IotServerProviderProtocol>

- (instancetype)init __attribute__((unavailable("dont use init, use initWithInjection")));

- (instancetype)initWithInjection:(id<IotServerProviderInjection>)injection;

@end
