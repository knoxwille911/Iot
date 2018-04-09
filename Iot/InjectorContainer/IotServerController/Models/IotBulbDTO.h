//
//  BulbDTO.h
//  Iot
//
//  Created by Dmtech on 06.04.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface IotBulbDTO : MTLModel<MTLJSONSerializing>

@property (nonatomic ,strong) NSString *bulbName;
@property (nonatomic ,strong) NSString *bulbPower;
@property (nonatomic ,strong) NSNumber *bulbColorTemperature;
@property (nonatomic ,strong) NSNumber *bulbBrightness;
@property (nonatomic ,strong) NSDictionary *rgbMapBulbName;

-(BOOL)isOn;
-(BOOL)isNightMode;

@end
