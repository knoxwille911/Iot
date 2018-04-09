//
//  IotDevicesTableViewDeviceCell.h
//  Iot
//
//  Created by Dmtech on 09.04.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IotDevicesTableViewDeviceCell : UITableViewCell

@property (nonatomic, strong) UIImageView *devicetopIcon;
@property (nonatomic, strong) UILabel *deviceNameLabel;

@property (nonatomic, strong) UILabel *deviceIDTitleLabel;
@property (nonatomic, strong) UILabel *deviceIDValueLabel;

@property (nonatomic, strong) UILabel *deviceLightTitleLabel;
@property (nonatomic, strong) UILabel *deviceLightValueLabel;

@property (nonatomic, strong) UILabel *deviceTemperatureTitleLabel;
@property (nonatomic, strong) UILabel *deviceTemperatureValueLabel;

@property (nonatomic, strong) UILabel *devicePresureTitleLabel;
@property (nonatomic, strong) UILabel *devicePresureValueLabel;

@property (nonatomic, strong) UILabel *deviceHumidityTitleLabel;
@property (nonatomic, strong) UILabel *deviceHumidityValueLabel;

@property (nonatomic, strong) UILabel *deviceTimestampLabel;
@property (nonatomic, strong) UILabel *deviceTimestampValueLabel;

@property (nonatomic, strong) UIButton *deviceUpdateButton;

@end
