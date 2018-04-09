//
//  IotDevicesTableViewBublCell.h
//  Iot
//
//  Created by Dmtech on 06.04.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, IotDevicesTableViewBublCellButtonType) {
    IotDevicesTableViewBublCellButtonTypeDefault,
    IotDevicesTableViewBublCellButtonTypeSwithOn,
    IotDevicesTableViewBublCellButtonTypeNightOn,
    IotDevicesTableViewBublCellButtonTypeRGB,
    IotDevicesTableViewBublCellButtonTypeUpdate,
    IotDevicesTableViewBublCellButtonTypeCount
};

@interface IotDevicesTableViewBublCell : UITableViewCell

@property (nonatomic, strong) UIImageView *bubltopIcon;
@property (nonatomic, strong) UILabel *bublNameLabel;

@property (nonatomic, strong) UILabel *bublPowerTitleLabel;
@property (nonatomic, strong) UILabel *bublPowerValueLabel;

@property (nonatomic, strong) UILabel *bublTempetureTitleLabel;
@property (nonatomic, strong) UILabel *bublTempetureValueLabel;

@property (nonatomic, strong) UILabel *bublBrigtnessTitleLabel;
@property (nonatomic, strong) UILabel *bublBrigtnessValueLabel;

@property (nonatomic, strong) UILabel *bublRGBTitleLabel;
@property (nonatomic, strong) UILabel *bublRGBValueLabel;

@property (nonatomic, strong) UIButton *bublDefaultButton;
@property (nonatomic, strong) UIButton *bublOnButton;
@property (nonatomic, strong) UIButton *bublNightButton;
@property (nonatomic, strong) UIButton *bublRGBButton;
@property (nonatomic, strong) UIButton *bublUpdateButton;

@end
