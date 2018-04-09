//
//  BulbDTO.m
//  Iot
//
//  Created by Dmtech on 06.04.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

#import "IotBulbDTO.h"

static NSString *kIotBulbDTOOn = @"on";
static NSString *kIotBulbDTOOff = @"off";

@implementation IotBulbDTO

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return  @{
               @keypath(IotBulbDTO.new, bulbName)             : @"name",
               @keypath(IotBulbDTO.new, bulbPower)            : @"power",
               @keypath(IotBulbDTO.new, bulbColorTemperature) : @"colorTemperature",
               @keypath(IotBulbDTO.new, bulbBrightness)       : @"brightness",
               @keypath(IotBulbDTO.new, rgbMapBulbName)       : @"rgbMap"
               };
}


-(BOOL)isOn {
    return [self.bulbPower isEqualToString:kIotBulbDTOOn];
}


-(BOOL)isNightMode {
    return NO;
}

@end
