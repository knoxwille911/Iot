//
//  IotDevicesViewController.m
//  Iot
//
//  Created by Dmtech on 05.04.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

#import "IotDevicesViewController.h"
#import "IotInjectorContainer.h"
#import "IotServerProvider.h"
#import "IotDevicesTableViewDataSource.h"
#import "IotDevicesTableViewBublCell.h"
#import "IotDevicesTableViewDeviceCell.h"
#import "UIColor+SPColors.h"

@interface IotDevicesViewController ()<UITableViewDelegate> {
    UITableView *_tableView;
    IotDevicesTableViewDataSource *_dataSource;
}
@end

@implementation IotDevicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor deviceListControllerBackgroundColor];
    self.title = NSLocalizedString(@"Devices", @"Devices");
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [_tableView registerClass:[IotDevicesTableViewBublCell class] forCellReuseIdentifier:NSStringFromClass([IotDevicesTableViewBublCell class])];
    [_tableView registerClass:[IotDevicesTableViewDeviceCell class] forCellReuseIdentifier:NSStringFromClass([IotDevicesTableViewDeviceCell class])];
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    
    _tableView.delegate = self;
    _dataSource = [[IotDevicesTableViewDataSource alloc] initWithTableView:_tableView targetViewControler:self];
    _tableView.dataSource = _dataSource;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    _tableView.bounces = NO;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 80;
    _tableView.clipsToBounds = YES;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    
    [self setupLayout];
    
    [_dataSource downloadAndRefreshData];
}


-(void)setupLayout {
    NSLayoutAnchor *topSaveAnchor;
    NSLayoutAnchor *bottomSaveAnchor;
    if (@available(iOS 11, *)) {
        bottomSaveAnchor = self.view.safeAreaLayoutGuide.bottomAnchor;
    } else {
        bottomSaveAnchor = self.bottomLayoutGuide.topAnchor;
    }
    
    
    if (@available(iOS 11, *)) {
        topSaveAnchor = self.view.safeAreaLayoutGuide.topAnchor;
    } else {
        topSaveAnchor = self.topLayoutGuide.bottomAnchor;
    }
    
    [_tableView.topAnchor constraintEqualToAnchor:topSaveAnchor constant:0].active = YES;
    [_tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:0].active = YES;
    [_tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:0].active = YES;
    [_tableView.bottomAnchor constraintEqualToAnchor:bottomSaveAnchor constant:0].active = YES;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

@end
