//
//  IotConversationDetailTableViewWrapperView.m
//  Iot
//
//  Created by Dmtech on 10.04.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

#import "IotConversationDetailTableViewWrapperView.h"
#import "IotConversationDetailTableViewCell.h"
#import "IotConversationDetailTableViewDataSourse.h"
#import "IotConversationDetailDataController.h"

@interface IotConversationDetailTableViewWrapperView() {
    UITableView *_tableView;
    IotConversationDetailTableViewDataSourse *_tableViewDataSource;
    IotConversationDetailDataController *_dataController;
    NSLayoutConstraint *_bottomConstraint;
}

@end


@implementation IotConversationDetailTableViewWrapperView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(keyboardWillShow:)
//                                                     name:UIKeyboardWillShowNotification
//                                                   object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(keyboardWillHide:)
//                                                     name:UIKeyboardWillHideNotification
//                                                   object:nil];
        [self setupView];
    }
    return self;
}


-(void)setupView {
    self.backgroundColor = [UIColor clearColor];
    _tableView = [UITableView new];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    _tableView.clipsToBounds = YES;
    _tableView.allowsSelection = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:_tableView];
    
    _dataController = [[IotConversationDetailDataController alloc] init];
    _tableViewDataSource = [[IotConversationDetailTableViewDataSourse alloc] initWithDataController:_dataController tableView:_tableView];
    
    _tableView.delegate = _tableViewDataSource;
    _tableView.dataSource = _tableViewDataSource;
    
    [_tableView.topAnchor constraintEqualToAnchor:self.topAnchor constant:0].active = YES;
    [_tableView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:0].active = YES;
    [_tableView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:0].active = YES;
    _bottomConstraint = [_tableView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0];
    _bottomConstraint.active = YES;
    
    [_tableView registerClass:[IotConversationDetailTableViewCell class] forCellReuseIdentifier:NSStringFromClass([IotConversationDetailTableViewCell class])];
}


-(void)addReceivedMessage:(IotConversationAnswerOutDTO *)message {
    [_dataController addReceivedMessage:message withCompletion:^(BOOL result) {
        
    }];
}


-(void)addOutgoingMessage:(IotConversationAnswerOutDTO *)message {
    [_dataController addOutgoingMessage:message withCompletion:^(BOOL result) {
        
    }];
}


//- (void)keyboardWillShow:(NSNotification *)notification
//{
//    
//
//    dispatch_async(dispatch_get_main_queue(), ^{
//        //This code will run in the main thread:
//
//        NSDictionary *userInfo = [notification userInfo];
//        CGSize size = [[userInfo objectForKey: UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
//        CGRect frame = CGRectMake(_tableView.frame.origin.x,
//                                  _tableView.frame.origin.y,
//                                  _tableView.frame.size.width,
//                                  _tableView.frame.size.height - size.height);
//        _bottomConstraint.constant = -CGRectGetHeight(frame);
//        
//        [self setNeedsLayout];
//        [self layoutIfNeeded];
//    });
//}
//
//
//-(void) keyboardWillHide:(NSNotification *)note{
//    _bottomConstraint.constant = 0;
//    
//    [self setNeedsLayout];
//    [self layoutIfNeeded];
//}

@end
