//
//  IotDataSensorDTO.h
//  Iot
//
//  Created by Dmtech on 06.04.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface IotDataSensorDTO : MTLModel<MTLJSONSerializing>

@property (nonatomic ,strong) NSNumber *dataSensorLight;
@property (nonatomic ,strong) NSNumber *dataSensorTemperature;
@property (nonatomic ,strong) NSNumber *dataSensorPressure;
@property (nonatomic ,strong) NSNumber *dataSensorHumidity;
@property (nonatomic ,strong) NSDate   *dataSensorTimestamp;

@end
