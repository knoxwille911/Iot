//
//  IotRecordReflectorView.m
//  Iot
//
//  Created by Pavel Skovorodko on 4/10/18.
//  Copyright © 2018 DMTech. All rights reserved.
//

#import "IotRecordReflectorView.h"
#import "SCSiriWaveformView.h"
#import "UIColor+SPColors.h"

@interface IotRecordReflectorView()

@property (nonatomic, strong) UILabel *promptLabel;
@property (nonatomic, strong) UIImageView *micImageView;
@property (nonatomic, strong) SCSiriWaveformView *waveformView;

@end

@implementation IotRecordReflectorView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        [self setupConstraints];
    }
    return self;
}

- (void)setupUI {
    self.layer.cornerRadius = 10.f;
    self.layer.borderWidth = 1.f;
    self.layer.borderColor = UIColor.conversationRecordReflectorViewBorderColor.CGColor;
    self.backgroundColor = UIColor.conversationRecordReflectorViewBackgroundColor;
    
    self.promptLabel = [UILabel new];
    self.promptLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.promptLabel.text = NSLocalizedString(@"Please speak", @"Please speak");
    self.promptLabel.font = [UIFont systemFontOfSize:20.f weight:UIFontWeightMedium];
    self.promptLabel.textColor = UIColor.conversationRecordReflectorViewTextColor;
    [self addSubview:self.promptLabel];
    
    self.micImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Button-speech-recognition"]];
    self.micImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.micImageView];
    
    self.waveformView = [SCSiriWaveformView new];
    self.waveformView.translatesAutoresizingMaskIntoConstraints = NO;
    self.waveformView.backgroundColor = UIColor.clearColor;
    [self.waveformView setWaveColor:UIColor.conversationRecordReflectorViewWaveColor];
    [self.waveformView setPrimaryWaveLineWidth:3.f];
    [self.waveformView setSecondaryWaveLineWidth:1.f];
    [self addSubview:self.waveformView];
}

- (void)setupConstraints {
    [self.promptLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:15.f].active = YES;
    [self.promptLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor constant:0.f].active = YES;
    
    [self.micImageView.topAnchor constraintEqualToAnchor:self.promptLabel.bottomAnchor constant:15.f].active = YES;
    [self.micImageView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor constant:0.f].active = YES;
    [self.micImageView.widthAnchor constraintEqualToConstant:50.f].active = YES;
    [self.micImageView.heightAnchor constraintEqualToConstant:50.f].active = YES;
    
    [self.waveformView.topAnchor constraintEqualToAnchor:self.micImageView.bottomAnchor constant:10.f].active = YES;
    [self.waveformView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:1.f].active = YES;
    [self.waveformView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-1.f].active = YES;
    [self.waveformView.heightAnchor constraintEqualToConstant:50.f].active = YES;
    [self.waveformView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-10.f].active = YES;
}

- (void)updateWaveWithValue:(CGFloat)value {
    CGFloat correctValue    = value > 1 ? 1.f : value;
    correctValue            = value < 0 ? 0.f : value;
    [self.waveformView updateWithLevel:correctValue];
}

@end
