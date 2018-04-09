//
//  SPEndpoints.h
//  SpeedTest
//
//  Created by Dmtech on 15.03.18.
//  Copyright © 2018 Dmtech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IotEndpoints : NSObject

+(NSString *)turnOnPowerBulbEndpoint;
+(NSString *)turnOffPowerBulbEndpoint;
+(NSString *)changeColorOfBulbEndpoint;
+(NSString *)returnDefaultStateOfBulbEndpoint;
+(NSString *)turnOnNightStateOfBulbEndpoint;
+(NSString *)turnOffNightStateOfBulbEndpoint;
+(NSString *)getInfoOfBulbEndpoint;
+(NSString *)getAllDevicesEndpoint;
+(NSString *)getXDKdeviceEndpoint;
+(NSString *)getConversationAnswerEndpoint;

@end
