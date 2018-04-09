//
//  IotDevicesTableViewDataSource.m
//  Iot
//
//  Created by Dmtech on 06.04.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

#import "IotDevicesTableViewDataSource.h"
#import "IotInjectorContainer.h"
#import "IotServerProvider.h"
#import "IotDevicesTableViewBublCell.h"
#import "IotXDKDTO.h"
#import "IotBulbDTO.h"
#import "IotDevicesTableViewDeviceCell.h"
#import "IotDataSensorDTO.h"

@implementation IotDevicesTableViewDataSource

-(void)getDataFromServerWithCompletion:(IotTableViewDataSourceHandler)handler {
    [injectorContainer().serverProvider getAllDevicesWithCompletionHandler:^(NSArray<MTLModel *> *objects) {
        if (handler) {
            handler(objects);
        }
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.objects.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    MTLModel *mntModel = self.objects[indexPath.row + indexPath.section];
    if ([mntModel isKindOfClass:[IotXDKDTO class]]) {

        IotXDKDTO *deviceModel = (IotXDKDTO *)mntModel;
        IotDevicesTableViewDeviceCell *deviceCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([IotDevicesTableViewDeviceCell class])];
        deviceCell.deviceNameLabel.text = deviceModel.XDKDeviceId;
        deviceCell.deviceIDTitleLabel.text = NSLocalizedString(@"TypeID: ", @"TypeID: ");
        deviceCell.deviceIDValueLabel.text = deviceModel.XDKTypeId;
        
        deviceCell.deviceLightTitleLabel.text = NSLocalizedString(@"Light: ", @"Light: ");
        deviceCell.deviceLightValueLabel.text = [NSString stringWithFormat:@"%ld %@", deviceModel.XDKData.dataSensorLight.longValue, NSLocalizedString(@"mLux", @"mLux")];
        
        deviceCell.deviceTemperatureTitleLabel.text = NSLocalizedString(@"Temperature: ", @"Temperature: ");
        deviceCell.deviceTemperatureValueLabel.text = [NSString stringWithFormat:@"%ld %@", deviceModel.XDKData.dataSensorTemperature.longValue, NSLocalizedString(@"mCelecius", @"mCelecius")];
        
        deviceCell.devicePresureTitleLabel.text = NSLocalizedString(@"Presure: ", @"Presure: ");
        deviceCell.devicePresureValueLabel.text = [NSString stringWithFormat:@"%ld %@", deviceModel.XDKData.dataSensorPressure.longValue, NSLocalizedString(@"Pascal", @"Pascal")];
        
        deviceCell.deviceHumidityTitleLabel.text = NSLocalizedString(@"Humidity: ", @"Humidity: ");
        deviceCell.deviceHumidityValueLabel.text = [NSString stringWithFormat:@"%ld %@", deviceModel.XDKData.dataSensorHumidity.longValue, NSLocalizedString(@"%rH", @"%rH")];
        
        deviceCell.deviceTimestampLabel.text = NSLocalizedString(@"Timestamp: ", @"Timestamp: ");
        deviceCell.deviceTimestampValueLabel.text = [NSString stringWithFormat:@"%@", [self deviceTimestampTextFromDate:deviceModel.XDKData.dataSensorTimestamp]];
        
        [deviceCell.deviceUpdateButton addTarget:self action:@selector(updateDeviceButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        cell = (UITableViewCell *)deviceCell;
    }
    else {
        IotBulbDTO *bulbModel = (IotBulbDTO *)mntModel;
        IotDevicesTableViewBublCell *bubbleCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([IotDevicesTableViewBublCell class])];
        bubbleCell.bublNameLabel.text = bulbModel.bulbName;
        
        bubbleCell.bublPowerTitleLabel.text = NSLocalizedString(@"Power: ", @"Power: ");
        bubbleCell.bublPowerValueLabel.text = bulbModel.bulbPower;
        
        bubbleCell.bublTempetureTitleLabel.text = NSLocalizedString(@"Color temperature: ", @"Color temperature: ");
        bubbleCell.bublTempetureValueLabel.text = [NSString stringWithFormat:@"%@", bulbModel.bulbColorTemperature];
        
        bubbleCell.bublBrigtnessTitleLabel.text = NSLocalizedString(@"Brightness: ", @"Brightness: ");
        bubbleCell.bublBrigtnessValueLabel.text = [bulbModel.bulbBrightness stringValue];
        
        bubbleCell.bublRGBTitleLabel.text = NSLocalizedString(@"RGB: ", @"RGB: ");
        
        NSNumber *red = bulbModel.rgbMapBulbName[@"Red"];
        NSNumber *green = bulbModel.rgbMapBulbName[@"Green"];
        NSNumber *blue = bulbModel.rgbMapBulbName[@"Blue"];
        
        bubbleCell.bublRGBValueLabel.text = [NSString stringWithFormat:@"Red: %ld Green: %ld Blue: %ld", red.integerValue, green.integerValue, blue.integerValue];
        
        [bubbleCell.bublDefaultButton addTarget:self action:@selector(defaultButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [bubbleCell.bublOnButton addTarget:self action:@selector(switchOnButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [bubbleCell.bublNightButton addTarget:self action:@selector(nightOnButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [bubbleCell.bublRGBButton addTarget:self action:@selector(rgbButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [bubbleCell.bublUpdateButton addTarget:self action:@selector(updateButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        cell = (UITableViewCell *)bubbleCell;
    }
    return cell;
}




-(NSString *)deviceTimestampTextFromDate:(NSDate *)date {
    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
    [dateformat setDateFormat:@"dd/MM/yyyy hh:mm"];
    NSString *messageDate = [dateformat stringFromDate:date];
    return messageDate;
}



-(void)updateDeviceButtonTapped:(UIButton *)button {
    
}


-(void)defaultButtonTapped:(UIButton *)button {
    if ([self bulbForTapButton:button]) {
        NSIndexPath *indexPath = [self indexForButton:button];
        if (indexPath) {
            __weak IotDevicesTableViewDataSource *weakSelf = self;
            IotBulbDTO *bulb = [self bulbForTapButton:button];
            [injectorContainer().serverProvider returnDefaultStateOfBulbWithId:bulb.bulbName withCompletion:^(BOOL result) {
                if (result) {
                    [weakSelf updateBublAtIndex:indexPath];
                }
            }];
        }
    }
}


-(void)switchOnButtonTapped:(UIButton *)button {
    IotBulbDTO *bulb = [self bulbForTapButton:button];
    if (bulb) {
        NSIndexPath *indexPath = [self indexForButton:button];
        if (indexPath) {
            __weak IotDevicesTableViewDataSource *weakSelf = self;
            if ([bulb isOn]) {
                [injectorContainer().serverProvider turnOffPowerBulbWithBulbId:bulb.bulbName withCompletion:^(BOOL result) {
                    [weakSelf updateBublAtIndex:indexPath];
                }];
            }
            else {
                [injectorContainer().serverProvider turnOnPowerBulbWithBulbId:bulb.bulbName withCompletion:^(BOOL result) {
                    [weakSelf updateBublAtIndex:indexPath];
                }];
            }
        }
    }
}


-(void)nightOnButtonTapped:(UIButton *)button {
    IotBulbDTO *bulb = [self bulbForTapButton:button];
    if (bulb) {
        NSIndexPath *indexPath = [self indexForButton:button];
        if (indexPath) {
            __weak IotDevicesTableViewDataSource *weakSelf = self;
            if ([bulb isNightMode]) {
                [injectorContainer().serverProvider turnOffNightStateOfBulbWithBulbId:bulb.bulbName withCompletion:^(BOOL result) {
                    [weakSelf updateBublAtIndex:indexPath];
                }];
            }
            else {
                [injectorContainer().serverProvider turnOnNightStateOfBulbWithBulbId:bulb.bulbName withCompletion:^(BOOL result) {
                    [weakSelf updateBublAtIndex:indexPath];
                }];
            }
        }
    }
}


-(void)rgbButtonTapped:(UIButton *)button {
    
}


-(void)updateButtonTapped:(UIButton *)button {
    [self updateBublAtIndex:[self indexForButton:button]];
}


-(NSIndexPath *)indexForButton:(UIButton *)button {
    UITableViewCell* cell = [self parentCellForView:button];
    NSIndexPath* indexPath = [self.tableView indexPathForCell:cell];
    return indexPath;
}


-(UITableViewCell *)parentCellForView:(id)theView {
    id viewSuperView = [theView superview];
    while (viewSuperView != nil) {
        if ([viewSuperView isKindOfClass:[UITableViewCell class]]) {
            return (UITableViewCell *)viewSuperView;
        }
        else {
            viewSuperView = [viewSuperView superview];
        }
    }
    return nil;
}


-(IotBulbDTO *)bulbForTapButton:(UIButton *)button {
    NSIndexPath *indexPath = [self indexForButton:button];
    if (indexPath) {
        MTLModel *mntModel = self.objects[indexPath.row + indexPath.section];
        if ([mntModel isKindOfClass:[IotBulbDTO class]]) {
            IotBulbDTO *bulbModel = (IotBulbDTO *)mntModel;
            return bulbModel;
        }
        return nil;
    }
    return nil;
}


-(void)updateBublAtIndex:(NSIndexPath *)indexPath {
    MTLModel *mntModel = self.objects[indexPath.row + indexPath.section];
    IotBulbDTO *bulbModel = (IotBulbDTO *)mntModel;
    __weak IotDevicesTableViewDataSource *weakSelf = self;
    [injectorContainer().serverProvider getInfoOfBulbWithBulbId:@"0" withCompletionHandler:^(NSArray<MTLModel *> *objects) {
        if (objects.count) {
            IotBulbDTO *updatedBulbModel = (IotBulbDTO *)[objects firstObject];
            bulbModel.bulbColorTemperature = updatedBulbModel.bulbColorTemperature;
            bulbModel.bulbName = updatedBulbModel.bulbName;
            bulbModel.bulbPower = updatedBulbModel.bulbPower;
            bulbModel.bulbBrightness = updatedBulbModel.bulbBrightness;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            });
        }
    }];
}

@end
