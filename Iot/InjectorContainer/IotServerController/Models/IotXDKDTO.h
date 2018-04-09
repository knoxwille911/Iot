//
//  IotXDKDTO.h
//  Iot
//
//  Created by Dmtech on 06.04.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

#import <Mantle/Mantle.h>

@class IotDataSensorDTO;

@interface IotXDKDTO : MTLModel<MTLJSONSerializing>

@property (nonatomic ,strong) NSString *XDKCliendId;
@property (nonatomic ,strong) NSString *XDKDeviceId;
@property (nonatomic ,strong) NSString *XDKTypeId;
@property (nonatomic ,strong) IotDataSensorDTO *XDKData;

@end
