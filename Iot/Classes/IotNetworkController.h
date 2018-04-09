//
//  PCNetworkController.h
//  PEN
//
//  Created by Dmtech on 11.09.17.
//  Copyright © 2017 DarkMatterAB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IotNetworkControllerProtocol.h"

@protocol IotNetworkControllerInjection<NSObject>

@end

@interface IotNetworkController : NSObject<IotNetworkControllerProtocol>

- (instancetype)init __attribute__((unavailable("dont use init, use initWithInjection")));

- (instancetype)initWithInjection:(id<IotNetworkControllerInjection>)injection;

@end
