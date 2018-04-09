//
//  IotTableViewDataSource.m
//  Iot
//
//  Created by Dmtech on 06.04.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

#import "IotTableViewDataSource.h"
#import "IotInjectorContainer.h"

@interface IotTableViewDataSource()<UITableViewDataSource> {
    
}

@end


@implementation IotTableViewDataSource

-(instancetype)initWithTableView:(UITableView *)tableView {
    if (self = [super init]) {
        self.tableView = tableView;
    }
    return self;
}


-(void)downloadAndRefreshData {
    [self getDataFromServerWithCompletion:^(NSArray<MTLModel *> *array) {
        self.objects = array;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}


-(void)getDataFromServerWithCompletion:(IotTableViewDataSourceHandler)handler {
    NSAssert(YES, @"should be overriden");
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger countOfOnjects = self.objects.count;
    return countOfOnjects > 0 ? countOfOnjects : 0;
}

@end
