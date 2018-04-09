//
//  IotXDKDTO.m
//  Iot
//
//  Created by Dmtech on 06.04.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

#import "IotXDKDTO.h"
#import "IotDataSensorDTO.h"

@implementation IotXDKDTO

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return  @{
               @keypath(IotXDKDTO.new, XDKCliendId) : @"clientId",
               @keypath(IotXDKDTO.new, XDKDeviceId) : @"deviceId",
               @keypath(IotXDKDTO.new, XDKTypeId)   : @"typeId",
               @keypath(IotXDKDTO.new, XDKData)     : @"data"
               };
}


+ (NSValueTransformer *)XDKDataJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[IotDataSensorDTO class]];
}

@end
