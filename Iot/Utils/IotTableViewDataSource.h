//
//  IotTableViewDataSource.h
//  Iot
//
//  Created by Dmtech on 06.04.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^IotTableViewDataSourceHandler) (NSArray<MTLModel *> *array);

@interface IotTableViewDataSource : NSObject

-(instancetype)initWithTableView:(UITableView *)tableView;

-(void)downloadAndRefreshData;
-(void)getDataFromServerWithCompletion:(IotTableViewDataSourceHandler)handler;

@property (nonatomic, strong) NSArray<MTLModel *> *objects;
@property (nonatomic, weak) UITableView *tableView;

@end
