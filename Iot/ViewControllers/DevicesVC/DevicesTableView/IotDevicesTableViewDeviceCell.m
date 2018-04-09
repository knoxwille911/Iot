//
//  IotDevicesTableViewDeviceCell.m
//  Iot
//
//  Created by Dmtech on 09.04.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

#import "IotDevicesTableViewDeviceCell.h"
#import "UIColor+SPColors.h"

static NSString *kIotDevicesTableViewDeviceCellIconName = @"conversation_Button-paper-plane";


static NSString *kIotDevicesTableViewDeviceCellUpdateButtonIconName = @"conversation_Button-paper-plane";
static NSString *kIotDevicesTableViewDeviceCellUpdateButtonPressedIconName = @"conversation_Button-paper-plane";

@implementation IotDevicesTableViewDeviceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}


- (void)setupUI {
    self.backgroundColor = [UIColor devicesListCellBackgroundColor];
    UIView *separatorView;
    //top view
    {
        self.devicetopIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kIotDevicesTableViewDeviceCellIconName]];
        self.devicetopIcon.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.devicetopIcon];
        
        [self.devicetopIcon.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:15.f].active = YES;
        [self.devicetopIcon.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:15.f].active = YES;
        
        self.deviceNameLabel = [UILabel new];
        self.deviceNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.deviceNameLabel.textColor = [UIColor devicesListTitleTextColor];
        self.deviceNameLabel.font = [self titleLabelFont];
        [self.contentView addSubview:self.deviceNameLabel];
        
        [self.deviceNameLabel.leadingAnchor constraintEqualToAnchor:self.devicetopIcon.trailingAnchor constant:15.f].active = YES;
        [self.deviceNameLabel.centerYAnchor constraintEqualToAnchor:self.devicetopIcon.centerYAnchor constant:0].active = YES;
        
        
        separatorView = [UIView new];
        separatorView.translatesAutoresizingMaskIntoConstraints = NO;
        separatorView.backgroundColor = [UIColor devicesListSeparatorColor];
        [self.contentView addSubview:separatorView];
        
        [separatorView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:0].active = YES;
        [separatorView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:0].active = YES;
        [separatorView.topAnchor constraintEqualToAnchor:self.devicetopIcon.bottomAnchor constant:5].active = YES;
        [separatorView.heightAnchor constraintEqualToConstant:1].active = YES;
    }
    // center view
    {
        self.deviceIDTitleLabel = [UILabel new];
        self.deviceIDTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.deviceIDTitleLabel.textColor = [UIColor devicesListTitleTextColor];
        self.deviceIDTitleLabel.font = [self titleLabelFont];
        [self.contentView addSubview:self.deviceIDTitleLabel];
        
        [self.deviceIDTitleLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:[self leftOffsetForTitleLabel]].active = YES;
        [self.deviceIDTitleLabel.topAnchor constraintEqualToAnchor:separatorView.bottomAnchor constant:5.f].active = YES;
        
        
        self.deviceIDValueLabel = [UILabel new];
        self.deviceIDValueLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.deviceIDValueLabel.textColor = [UIColor devicesListValueTextColor];
        self.deviceIDValueLabel.font = [self titleLabelFont];
        [self.contentView addSubview:self.deviceIDValueLabel];
        
        [self.deviceIDValueLabel.leadingAnchor constraintEqualToAnchor:self.deviceIDTitleLabel.trailingAnchor constant:[self leftOffsetForValueLabel]].active = YES;
        [self.deviceIDValueLabel.centerYAnchor constraintEqualToAnchor:self.deviceIDTitleLabel.centerYAnchor constant:0.f].active = YES;
    }
    {
        self.deviceLightTitleLabel = [UILabel new];
        self.deviceLightTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.deviceLightTitleLabel.textColor = [UIColor devicesListTitleTextColor];
        self.deviceLightTitleLabel.font = [self titleLabelFont];
        [self.contentView addSubview:self.deviceLightTitleLabel];
        
        [self.deviceLightTitleLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:[self leftOffsetForTitleLabel]].active = YES;
        [self.deviceLightTitleLabel.topAnchor constraintEqualToAnchor:self.deviceIDValueLabel.bottomAnchor constant:[self titlelabelTopOffset]].active = YES;
        
        
        self.deviceLightValueLabel = [UILabel new];
        self.deviceLightValueLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.deviceLightValueLabel.textColor = [UIColor devicesListValueTextColor];
        self.deviceLightValueLabel.font = [self titleLabelFont];
        [self.contentView addSubview:self.deviceLightValueLabel];
        
        [self.deviceLightValueLabel.leadingAnchor constraintEqualToAnchor:self.deviceLightTitleLabel.trailingAnchor constant:[self leftOffsetForValueLabel]].active = YES;
        [self.deviceLightValueLabel.centerYAnchor constraintEqualToAnchor:self.deviceLightTitleLabel.centerYAnchor constant:0.f].active = YES;
    }
    {
        self.deviceTemperatureTitleLabel = [UILabel new];
        self.deviceTemperatureTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.deviceTemperatureTitleLabel.textColor = [UIColor devicesListTitleTextColor];
        self.deviceTemperatureTitleLabel.font = [self titleLabelFont];
        [self.contentView addSubview:self.deviceTemperatureTitleLabel];
        
        [self.deviceTemperatureTitleLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:[self leftOffsetForTitleLabel]].active = YES;
        [self.deviceTemperatureTitleLabel.topAnchor constraintEqualToAnchor:self.deviceLightTitleLabel.bottomAnchor constant:[self titlelabelTopOffset]].active = YES;
        
        
        self.deviceTemperatureValueLabel = [UILabel new];
        self.deviceTemperatureValueLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.deviceTemperatureValueLabel.textColor = [UIColor devicesListValueTextColor];
        self.deviceTemperatureValueLabel.font = [self titleLabelFont];
        [self.contentView addSubview:self.deviceTemperatureValueLabel];
        
        [self.deviceTemperatureValueLabel.leadingAnchor constraintEqualToAnchor:self.deviceTemperatureTitleLabel.trailingAnchor constant:[self leftOffsetForValueLabel]].active = YES;
        [self.deviceTemperatureValueLabel.centerYAnchor constraintEqualToAnchor:self.deviceTemperatureTitleLabel.centerYAnchor constant:0.f].active = YES;
    }
    {
        self.devicePresureTitleLabel = [UILabel new];
        self.devicePresureTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.devicePresureTitleLabel.textColor = [UIColor devicesListTitleTextColor];
        self.devicePresureTitleLabel.font = [self titleLabelFont];
        [self.contentView addSubview:self.devicePresureTitleLabel];
        
        [self.devicePresureTitleLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:[self leftOffsetForTitleLabel]].active = YES;
        [self.devicePresureTitleLabel.topAnchor constraintEqualToAnchor:self.deviceTemperatureTitleLabel.bottomAnchor constant:[self titlelabelTopOffset]].active = YES;
        
        
        self.devicePresureValueLabel = [UILabel new];
        self.devicePresureValueLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.devicePresureValueLabel.textColor = [UIColor devicesListValueTextColor];
        self.devicePresureValueLabel.font = [self titleLabelFont];
        [self.contentView addSubview:self.devicePresureValueLabel];
        
        [self.devicePresureValueLabel.leadingAnchor constraintEqualToAnchor:self.devicePresureTitleLabel.trailingAnchor constant:[self leftOffsetForValueLabel]].active = YES;
        [self.devicePresureValueLabel.centerYAnchor constraintEqualToAnchor:self.devicePresureTitleLabel.centerYAnchor constant:0.f].active = YES;
    }
    {
        self.deviceHumidityTitleLabel = [UILabel new];
        self.deviceHumidityTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.deviceHumidityTitleLabel.textColor = [UIColor devicesListTitleTextColor];
        self.deviceHumidityTitleLabel.font = [self titleLabelFont];
        [self.contentView addSubview:self.deviceHumidityTitleLabel];
        
        [self.deviceHumidityTitleLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:[self leftOffsetForTitleLabel]].active = YES;
        [self.deviceHumidityTitleLabel.topAnchor constraintEqualToAnchor:self.devicePresureValueLabel.bottomAnchor constant:[self titlelabelTopOffset]].active = YES;
        
        
        self.deviceHumidityValueLabel = [UILabel new];
        self.deviceHumidityValueLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.deviceHumidityValueLabel.textColor = [UIColor devicesListValueTextColor];
        self.deviceHumidityValueLabel.font = [self titleLabelFont];
        [self.contentView addSubview:self.deviceHumidityValueLabel];
        
        [self.deviceHumidityValueLabel.leadingAnchor constraintEqualToAnchor:self.deviceHumidityTitleLabel.trailingAnchor constant:[self leftOffsetForValueLabel]].active = YES;
        [self.deviceHumidityValueLabel.centerYAnchor constraintEqualToAnchor:self.deviceHumidityTitleLabel.centerYAnchor constant:0.f].active = YES;
    }
    {
        self.deviceTimestampLabel = [UILabel new];
        self.deviceTimestampLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.deviceTimestampLabel.textColor = [UIColor devicesListTitleTextColor];
        self.deviceTimestampLabel.font = [self titleLabelFont];
        [self.contentView addSubview:self.deviceTimestampLabel];
        
        [self.deviceTimestampLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:[self leftOffsetForTitleLabel]].active = YES;
        [self.deviceTimestampLabel.topAnchor constraintEqualToAnchor:self.deviceHumidityTitleLabel.bottomAnchor constant:[self titlelabelTopOffset]].active = YES;
        
        
        self.deviceTimestampValueLabel = [UILabel new];
        self.deviceTimestampValueLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.deviceTimestampValueLabel.textColor = [UIColor devicesListValueTextColor];
        self.deviceTimestampValueLabel.font = [self titleLabelFont];
        [self.contentView addSubview:self.deviceTimestampValueLabel];
        
        [self.deviceTimestampValueLabel.leadingAnchor constraintEqualToAnchor:self.deviceTimestampLabel.trailingAnchor constant:[self leftOffsetForValueLabel]].active = YES;
        [self.deviceTimestampValueLabel.centerYAnchor constraintEqualToAnchor:self.deviceTimestampLabel.centerYAnchor constant:0.f].active = YES;
    }
    //bottom view
    UIView *bottomSeparatorView = [UIView new];
    bottomSeparatorView.translatesAutoresizingMaskIntoConstraints = NO;
    bottomSeparatorView.backgroundColor = [UIColor devicesListSeparatorColor];
    [self.contentView addSubview:bottomSeparatorView];
    
    [bottomSeparatorView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:0].active = YES;
    [bottomSeparatorView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:0].active = YES;
    [bottomSeparatorView.topAnchor constraintEqualToAnchor:self.deviceTimestampValueLabel.bottomAnchor constant:5].active = YES;
    [bottomSeparatorView.heightAnchor constraintEqualToConstant:1].active = YES;

    self.deviceUpdateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *defaultImage = [UIImage imageNamed:kIotDevicesTableViewDeviceCellUpdateButtonIconName];
    UIImage *presedImage = [UIImage imageNamed:kIotDevicesTableViewDeviceCellUpdateButtonPressedIconName];
    
    [self.deviceUpdateButton setBackgroundImage:defaultImage forState:UIControlStateNormal];
    [self.deviceUpdateButton setBackgroundImage:presedImage forState:UIControlStateSelected];
    self.deviceUpdateButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.deviceUpdateButton];
    
    [self.deviceUpdateButton.topAnchor constraintEqualToAnchor:bottomSeparatorView.bottomAnchor constant:5].active = YES;
    [self.deviceUpdateButton.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-20].active = YES;
    [self.deviceUpdateButton.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:0.f].active = YES;
}

-(UIFont *)titleLabelFont {
    return [UIFont systemFontOfSize:14];
}


-(CGFloat)leftOffsetForValueLabel {
    return 5.0f;
}


-(CGFloat)leftOffsetForTitleLabel {
    return 15.0f;
}


-(CGFloat)titlelabelTopOffset {
    return 7.0f;
}


-(void)prepareForReuse {
    [super prepareForReuse];
    self.deviceNameLabel.text = nil;
    self.deviceIDTitleLabel.text = nil;
    self.deviceIDValueLabel.text = nil;
    self.deviceLightTitleLabel.text = nil;
    self.deviceLightValueLabel.text = nil;
    self.deviceTemperatureTitleLabel.text = nil;
    self.deviceTemperatureValueLabel.text = nil;
    self.devicePresureTitleLabel.text = nil;
    self.devicePresureValueLabel.text = nil;
    self.deviceHumidityTitleLabel.text = nil;
    self.deviceHumidityValueLabel.text = nil;
    self.deviceTimestampLabel.text = nil;
    self.deviceTimestampValueLabel.text = nil;
}

@end
