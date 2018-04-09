//
//  IotDataSensorDTO.m
//  Iot
//
//  Created by Dmtech on 06.04.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

#import "IotDataSensorDTO.h"

@implementation IotDataSensorDTO

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return  @{
               @keypath(IotDataSensorDTO.new, dataSensorLight)       : @"light",
               @keypath(IotDataSensorDTO.new, dataSensorTemperature) : @"temperature",
               @keypath(IotDataSensorDTO.new, dataSensorPressure)    : @"pressure",
               @keypath(IotDataSensorDTO.new, dataSensorHumidity)    : @"humidity",
               @keypath(IotDataSensorDTO.new, dataSensorTimestamp)   : @"timestamp"
               };
}


+ (NSValueTransformer *)dataSensorTimestampJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber *date, BOOL *success, NSError *__autoreleasing *error) {
        NSDate *newDate;
        if ([self needDivideTo1000:date]) {
            newDate = [NSDate dateWithTimeIntervalSince1970:[date longLongValue] / 1000];
        }
        else {
            newDate = [NSDate dateWithTimeIntervalSince1970:[date longLongValue]];
        }
        return newDate;
    } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        return [NSNumber numberWithLong:[date timeIntervalSince1970]];
    }];
}


+(BOOL)needDivideTo1000:(NSNumber *)number {
    return ceil(log10 (number.doubleValue) > 12);
}

@end
