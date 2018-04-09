//
//  SPEndpoints.m
//  SpeedTest
//
//  Created by Dmtech on 15.03.18.
//  Copyright © 2018 Dmtech. All rights reserved.
//

#import "IotEndpoints.h"

static NSString *kIotBaseEndpoing = @"http://178.172.209.29:8888/iot-server-be/";

@implementation IotEndpoints

+(NSString *)turnOnPowerBulbEndpoint {
    return [kIotBaseEndpoing stringByAppendingString:@"light/on"];
}


+(NSString *)turnOffPowerBulbEndpoint {
    return [kIotBaseEndpoing stringByAppendingString:@"light/off"];
}


+(NSString *)changeColorOfBulbEndpoint {
    return [kIotBaseEndpoing stringByAppendingString:@"light/color"];
}


+(NSString *)returnDefaultStateOfBulbEndpoint {
    return [kIotBaseEndpoing stringByAppendingString:@"light/default"];
}


+(NSString *)turnOnNightStateOfBulbEndpoint {
    return [kIotBaseEndpoing stringByAppendingString:@"light/night/on"];
}


+(NSString *)turnOffNightStateOfBulbEndpoint {
    return [kIotBaseEndpoing stringByAppendingString:@"light/night/off"];
}


+(NSString *)getInfoOfBulbEndpoint {
    return [kIotBaseEndpoing stringByAppendingString:@"light/info"];
}


+(NSString *)getAllDevicesEndpoint {
    return [kIotBaseEndpoing stringByAppendingString:@"devices"];
}


+(NSString *)getXDKdeviceEndpoint {
    return [kIotBaseEndpoing stringByAppendingString:@"device"];
}


+(NSString *)getConversationAnswerEndpoint {
    return [kIotBaseEndpoing stringByAppendingString:@"conv/answer"];
}

@end
