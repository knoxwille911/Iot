//
//  IotConversationDetailTableViewDataSourse.h
//  Iot
//
//  Created by Dmtech on 10.04.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IotConversationDetailDataController;

@interface IotConversationDetailTableViewDataSourse : NSObject<UITableViewDataSource, UITableViewDelegate>

-(instancetype)initWithDataController:(IotConversationDetailDataController *)dataController tableView:(UITableView *)tableVie;

@end
