//
//  IotConversationDetailTableViewDataSourse.m
//  Iot
//
//  Created by Dmtech on 10.04.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

#import "IotConversationDetailTableViewDataSourse.h"
#import "IotConversationDetailDataController.h"
#import "IotConversationDetailTableViewCell.h"
#import "IotConversationDetailTableViewCell+Layout.h"
#import "IotConversationDetailMessageUIInfo.h"

@interface IotConversationDetailTableViewDataSourse()<IotConversationDetailDataControllerDelegate> {
    IotConversationDetailDataController *_dataController;
    __weak UITableView *_tableView;
}

@end


@implementation IotConversationDetailTableViewDataSourse

-(instancetype)initWithDataController:(IotConversationDetailDataController *)dataController tableView:(UITableView *)tableView {
    if (self = [super init]) {
        _dataController = dataController;
        _dataController.delegate = self;
        _tableView = tableView;
    }
    return self;
}


-(void)countOfMessagesWasChanged {
    dispatch_async(dispatch_get_main_queue(), ^{
        BOOL needToScrollDown = [self isOffsetIsMax];
        
        [_tableView reloadData];
        if (_dataController.messages.count > 0) {
            if (needToScrollDown) {
                [self updateBottomCollectionViewInsetWithAnimatin:NO];
            }
        }
    });
}


- (void)updateBottomCollectionViewInsetWithAnimatin:(BOOL)animation {
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_dataController.messages.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:animation];
}


-(BOOL)isOffsetIsMax {
    CGSize contentSize = _tableView.contentSize;
    CGRect collectionViewFrame = _tableView.frame;
    CGPoint contentOffset = _tableView.contentOffset;
    BOOL isOffsetMax = NO;
    if (contentOffset.y + CGRectGetHeight(collectionViewFrame) + 5 >= contentSize.height) {
        isOffsetMax = YES;
    }
    return isOffsetMax;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataController.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IotConversationDetailMessageUIInfo *uiInfo = [_dataController messageInfoForIndexPath:indexPath];
    IotConversationDetailTableViewCell *bubbleCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([IotConversationDetailTableViewCell class])];
    [bubbleCell setMessageData:uiInfo];
    return bubbleCell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    IotConversationDetailMessageUIInfo *uiInfo = [_dataController messageInfoForIndexPath:indexPath];
    
    CGSize rootCellSize = uiInfo.bubbleSize;
    
    //calculate with height of other views
    if (uiInfo.showAvatar && uiInfo.showTimeStamp) {
        rootCellSize.height += [IotConversationDetailTableViewCell titleHeight] + [IotConversationDetailTableViewCell titleInsetWithoutAvatar].top;
    }
    else if (uiInfo.showTimeStamp) {
        rootCellSize.height += [IotConversationDetailTableViewCell titleInsetWithoutAvatar].top + [IotConversationDetailTableViewCell titleHeight];
    }
    rootCellSize.height = rootCellSize.height + [IotConversationDetailTableViewCell bubbleInset].top + [IotConversationDetailTableViewCell bubbleInset].bottom;
    return rootCellSize.height;
    
    return uiInfo.bubbleSize.height;
}

@end
