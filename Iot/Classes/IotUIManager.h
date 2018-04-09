//
//  SPUIManager.h
//  SpeedTest
//
//  Created by Dmtech on 19.02.18.
//  Copyright © 2018 Dmtech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IotUIManagerProtocol.h"

@protocol IotUIManagerInjection<NSObject>

@end

@interface IotUIManager : NSObject<IotUIManagerProtocol>

- (instancetype)init __attribute__((unavailable("dont use init, use initWithInjection")));

- (instancetype)initWithInjection:(id<IotUIManagerInjection>)injection;


@end
