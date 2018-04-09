//
//  IotWrapperDTO.m
//  Iot
//
//  Created by Dmtech on 06.04.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

#import "IotWrapperDTO.h"
#import "IotXDKDTO.h"
#import "IotBulbDTO.h"

@implementation IotWrapperDTO

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return  @{
               @keypath(IotWrapperDTO.new, wrapperXdkList)  : @"xdkList",
               @keypath(IotWrapperDTO.new, wrapperbulbList) : @"bulbList"
               };
}


+ (NSValueTransformer *)wrapperXdkListJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[IotXDKDTO class]];
}


+ (NSValueTransformer *)wrapperbulbListJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[IotBulbDTO class]];
}

@end
