//
//  IotDevicesTableViewBublCell.m
//  Iot
//
//  Created by Dmtech on 06.04.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

#import "IotDevicesTableViewBublCell.h"

static NSString *kIotDevicesTableViewBublCellBubIconName = @"conversation_Button-paper-plane";


static NSString *kIotDevicesTableViewBublCellDefaultButtonIconName = @"conversation_Button-paper-plane";
static NSString *kIotDevicesTableViewBublCellDefaultButtonPressedIconName = @"conversation_Button-paper-plane";

static NSString *kIotDevicesTableViewBublCellSwithOnButtonIconName = @"conversation_Button-paper-plane";
static NSString *kIotDevicesTableViewBublCellSwithOnButtonPressedIconName = @"conversation_Button-paper-plane";

static NSString *kIotDevicesTableViewBublCellNightOnButtonIconName = @"conversation_Button-paper-plane";
static NSString *kIotDevicesTableViewBublCellNightOnButtonPressedIconName = @"conversation_Button-paper-plane";

static NSString *kIotDevicesTableViewBublCellRGBButtonIconName = @"conversation_Button-paper-plane";
static NSString *kIotDevicesTableViewBublCellRGBButtonPressedIconName = @"conversation_Button-paper-plane";

static NSString *kIotDevicesTableViewBublCellUpdateButtonIconName = @"conversation_Button-paper-plane";
static NSString *kIotDevicesTableViewBublCellUpdateButtonPressedIconName = @"conversation_Button-paper-plane";

@implementation IotDevicesTableViewBublCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}


- (void)setupUI {
    
    self.backgroundColor = UIColor.redColor;
    UIView *separatorView;
    //top view
    {
        self.bubltopIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kIotDevicesTableViewBublCellBubIconName]];
        self.bubltopIcon.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.bubltopIcon];
        
        [self.bubltopIcon.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:15.f].active = YES;
        [self.bubltopIcon.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:15.f].active = YES;
        
        self.bublNameLabel = [UILabel new];
        self.bublNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.bublNameLabel.textColor = [UIColor whiteColor];
        self.bublNameLabel.font = [self titleLabelFont];
        [self.contentView addSubview:self.bublNameLabel];
        
        [self.bublNameLabel.leadingAnchor constraintEqualToAnchor:self.bubltopIcon.trailingAnchor constant:15.f].active = YES;
        [self.bublNameLabel.centerYAnchor constraintEqualToAnchor:self.bubltopIcon.centerYAnchor constant:0].active = YES;
        
        
        separatorView = [UIView new];
        separatorView.translatesAutoresizingMaskIntoConstraints = NO;
        separatorView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:separatorView];
        
        [separatorView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:0].active = YES;
        [separatorView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:0].active = YES;
        [separatorView.topAnchor constraintEqualToAnchor:self.bubltopIcon.bottomAnchor constant:5].active = YES;
        [separatorView.heightAnchor constraintEqualToConstant:1].active = YES;
    }
    // center view
    {
        self.bublPowerTitleLabel = [UILabel new];
        self.bublPowerTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.bublPowerTitleLabel.textColor = [UIColor whiteColor];
        self.bublPowerTitleLabel.font = [self titleLabelFont];
        [self.contentView addSubview:self.bublPowerTitleLabel];
        
        [self.bublPowerTitleLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:[self leftOffsetForTitleLabel]].active = YES;
        [self.bublPowerTitleLabel.topAnchor constraintEqualToAnchor:separatorView.bottomAnchor constant:5.f].active = YES;
        
        
        self.bublPowerValueLabel = [UILabel new];
        self.bublPowerValueLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.bublPowerValueLabel.textColor = [UIColor whiteColor];
        self.bublPowerValueLabel.font = [self titleLabelFont];
        [self.contentView addSubview:self.bublPowerValueLabel];
        
        [self.bublPowerValueLabel.leadingAnchor constraintEqualToAnchor:self.bublPowerTitleLabel.trailingAnchor constant:[self leftOffsetForValueLabel]].active = YES;
        [self.bublPowerValueLabel.centerYAnchor constraintEqualToAnchor:self.bublPowerTitleLabel.centerYAnchor constant:0.f].active = YES;
    }
    {
        self.bublTempetureTitleLabel = [UILabel new];
        self.bublTempetureTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.bublTempetureTitleLabel.textColor = [UIColor whiteColor];
        self.bublTempetureTitleLabel.font = [self titleLabelFont];
        [self.contentView addSubview:self.bublTempetureTitleLabel];
        
        [self.bublTempetureTitleLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:[self leftOffsetForTitleLabel]].active = YES;
        [self.bublTempetureTitleLabel.topAnchor constraintEqualToAnchor:self.bublPowerValueLabel.bottomAnchor constant:[self titlelabelTopOffset]].active = YES;
        
        
        self.bublTempetureValueLabel = [UILabel new];
        self.bublTempetureValueLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.bublTempetureValueLabel.textColor = [UIColor whiteColor];
        self.bublTempetureValueLabel.font = [self titleLabelFont];
        [self.contentView addSubview:self.bublTempetureValueLabel];
        
        [self.bublTempetureValueLabel.leadingAnchor constraintEqualToAnchor:self.bublTempetureTitleLabel.trailingAnchor constant:[self leftOffsetForValueLabel]].active = YES;
        [self.bublTempetureValueLabel.centerYAnchor constraintEqualToAnchor:self.bublTempetureTitleLabel.centerYAnchor constant:0.f].active = YES;
    }
    {
        self.bublBrigtnessTitleLabel = [UILabel new];
        self.bublBrigtnessTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.bublBrigtnessTitleLabel.textColor = [UIColor whiteColor];
        self.bublBrigtnessTitleLabel.font = [self titleLabelFont];
        [self.contentView addSubview:self.bublBrigtnessTitleLabel];
        
        [self.bublBrigtnessTitleLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:[self leftOffsetForTitleLabel]].active = YES;
        [self.bublBrigtnessTitleLabel.topAnchor constraintEqualToAnchor:self.bublTempetureTitleLabel.bottomAnchor constant:[self titlelabelTopOffset]].active = YES;
        
        
        self.bublBrigtnessValueLabel = [UILabel new];
        self.bublBrigtnessValueLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.bublBrigtnessValueLabel.textColor = [UIColor whiteColor];
        self.bublBrigtnessValueLabel.font = [self titleLabelFont];
        [self.contentView addSubview:self.bublBrigtnessValueLabel];
        
        [self.bublBrigtnessValueLabel.leadingAnchor constraintEqualToAnchor:self.bublBrigtnessTitleLabel.trailingAnchor constant:[self leftOffsetForValueLabel]].active = YES;
        [self.bublBrigtnessValueLabel.centerYAnchor constraintEqualToAnchor:self.bublBrigtnessTitleLabel.centerYAnchor constant:0.f].active = YES;
    }
    {
        self.bublRGBTitleLabel = [UILabel new];
        self.bublRGBTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.bublRGBTitleLabel.textColor = [UIColor whiteColor];
        self.bublRGBTitleLabel.font = [self titleLabelFont];
        [self.contentView addSubview:self.bublRGBTitleLabel];
        
        [self.bublRGBTitleLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:[self leftOffsetForTitleLabel]].active = YES;
        [self.bublRGBTitleLabel.topAnchor constraintEqualToAnchor:self.bublBrigtnessTitleLabel.bottomAnchor constant:[self titlelabelTopOffset]].active = YES;
        
        
        self.bublRGBValueLabel = [UILabel new];
        self.bublRGBValueLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.bublRGBValueLabel.textColor = [UIColor whiteColor];
        self.bublRGBValueLabel.font = [self titleLabelFont];
        [self.contentView addSubview:self.bublRGBValueLabel];
        
        [self.bublRGBValueLabel.leadingAnchor constraintEqualToAnchor:self.bublRGBTitleLabel.trailingAnchor constant:[self leftOffsetForValueLabel]].active = YES;
        [self.bublRGBValueLabel.centerYAnchor constraintEqualToAnchor:self.bublRGBTitleLabel.centerYAnchor constant:0.f].active = YES;
    }
    //bottom view
    UIView *bottomSeparatorView = [UIView new];
    bottomSeparatorView.translatesAutoresizingMaskIntoConstraints = NO;
    bottomSeparatorView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bottomSeparatorView];
    
    [bottomSeparatorView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:0].active = YES;
    [bottomSeparatorView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:0].active = YES;
    [bottomSeparatorView.topAnchor constraintEqualToAnchor:self.bublRGBValueLabel.bottomAnchor constant:5].active = YES;
    [bottomSeparatorView.heightAnchor constraintEqualToConstant:1].active = YES;
    
    UIButton *previousButton = nil;
    
    for (IotDevicesTableViewBublCellButtonType i = 0; i < IotDevicesTableViewBublCellButtonTypeCount; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *defaultImage = nil;
        UIImage *presedImage = nil;
        switch (i) {
            case IotDevicesTableViewBublCellButtonTypeDefault:
                defaultImage = [UIImage imageNamed:kIotDevicesTableViewBublCellDefaultButtonIconName];
                presedImage = [UIImage imageNamed:kIotDevicesTableViewBublCellDefaultButtonPressedIconName];
                self.bublDefaultButton = button;
                break;
            case IotDevicesTableViewBublCellButtonTypeSwithOn:
                defaultImage = [UIImage imageNamed:kIotDevicesTableViewBublCellSwithOnButtonIconName];
                presedImage = [UIImage imageNamed:kIotDevicesTableViewBublCellSwithOnButtonPressedIconName];
                self.bublOnButton = button;
                break;
            case IotDevicesTableViewBublCellButtonTypeNightOn:
                defaultImage = [UIImage imageNamed:kIotDevicesTableViewBublCellNightOnButtonIconName];
                presedImage = [UIImage imageNamed:kIotDevicesTableViewBublCellNightOnButtonPressedIconName];
                self.bublNightButton = button;
                break;
            case IotDevicesTableViewBublCellButtonTypeRGB:
                defaultImage = [UIImage imageNamed:kIotDevicesTableViewBublCellRGBButtonIconName];
                presedImage = [UIImage imageNamed:kIotDevicesTableViewBublCellRGBButtonPressedIconName];
                self.bublRGBButton = button;
                break;
            case IotDevicesTableViewBublCellButtonTypeUpdate:
                defaultImage = [UIImage imageNamed:kIotDevicesTableViewBublCellUpdateButtonIconName];
                presedImage = [UIImage imageNamed:kIotDevicesTableViewBublCellUpdateButtonPressedIconName];
                self.bublUpdateButton = button;
                break;
            default:
                break;
        }
        button.tag = i;
        [button setBackgroundImage:defaultImage forState:UIControlStateNormal];
        [button setBackgroundImage:presedImage forState:UIControlStateSelected];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:button];
        
        [button.topAnchor constraintEqualToAnchor:bottomSeparatorView.bottomAnchor constant:5].active = YES;
        [button.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:0.f].active = YES;
        
        if (!previousButton) {
            [button.leadingAnchor constraintGreaterThanOrEqualToAnchor:self.contentView.leadingAnchor constant:100].active = YES;
        }
        else {
            [button.leadingAnchor constraintGreaterThanOrEqualToAnchor:previousButton.trailingAnchor constant:100].active = YES;
        }
        if (i == IotDevicesTableViewBublCellButtonTypeCount - 1) {
            [button.trailingAnchor constraintLessThanOrEqualToAnchor:self.contentView.trailingAnchor constant:-20].active = YES;
        }
        previousButton = button;
    }
}


-(CGFloat)bottomButtonImageHeight {
    return [UIImage imageNamed:kIotDevicesTableViewBublCellBubIconName].size.height;
}


-(UIFont *)titleLabelFont {
    return [UIFont systemFontOfSize:14];
}


-(CGFloat)leftOffsetForValueLabel {
    return 15.0f;
}


-(CGFloat)leftOffsetForTitleLabel {
    return 15.0f;
}


-(CGFloat)titlelabelTopOffset {
    return 7.0f;
}

@end
