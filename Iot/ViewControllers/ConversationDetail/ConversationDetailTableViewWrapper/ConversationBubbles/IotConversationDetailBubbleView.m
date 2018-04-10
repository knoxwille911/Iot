//
//  IotConversationDetailBubbleView.m
//  Iot
//
//  Created by Dmtech on 10.04.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

#import "IotConversationDetailBubbleView.h"
#import "IotConversationDetailMessageUIInfo.h"
#import "UIColor+SPColors.h"
#import "IotConversationDetailTextBubbleView.h"

CGFloat kIotConversationDetailMaxBubbleWidth = 200;

@implementation IotConversationDetailBubbleView

-(instancetype)initWithData:(IotConversationDetailMessageUIInfo *)params {
    CGRect bubbleFrame = CGRectMake(0, 0, params.bubbleSize.width, params.bubbleSize.height);
    if (self = [super initWithFrame:bubbleFrame]) {
        [self setupViewWithdata:params];
    }
    return self;
}

-(void)updateWithdata:(IotConversationDetailMessageUIInfo *)params {
    
    
}

-(void)setupViewWithdata:(IotConversationDetailMessageUIInfo *)params {
    UIView *bubbleImage = [self bubbleViewWithdata:params];
    [self addSubview:bubbleImage];
    [self autoresizesSubviews];
}


+(UIEdgeInsets)bubbleViewContentInset {
    NSAssert(0, @"should be overriden");
    return UIEdgeInsetsZero;
}


+(CGSize)bubbleSizeForData:(IotConversationDetailMessageUIInfo *)params {
    CGSize bubbleSize = CGSizeZero;
    switch (params.messageType) {
        case IotChatMessageTypeText:
            bubbleSize = [IotConversationDetailTextBubbleView bubbleSizeForData:params];
            bubbleSize.width += [IotConversationDetailTextBubbleView bubbleViewContentInset].left;
            bubbleSize.width += [IotConversationDetailTextBubbleView bubbleViewContentInset].right;
            
            bubbleSize.height += [IotConversationDetailTextBubbleView bubbleViewContentInset].top;
            bubbleSize.height += [IotConversationDetailTextBubbleView bubbleViewContentInset].bottom;
            break;
    }
    
    return bubbleSize;
}


-(UIView *)bubbleViewWithdata:(IotConversationDetailMessageUIInfo *)params {
    UIView *view = [[UIView alloc] initWithFrame:self.frame];
    view.backgroundColor = params.isOutgoing ? [UIColor conversationDetailOutgoindBubbleBackgroundColor] : [UIColor whiteColor];
    if (params.isOutgoing) {
        [self roundCornersOnView:view onTopLeft:YES topRight:YES bottomLeft:YES bottomRight:NO radius:22.f];
    }
    else {
        [self roundCornersOnView:view onTopLeft:NO topRight:YES bottomLeft:YES bottomRight:YES radius:22.f];
    }
    return view;
}


- (void)roundCornersOnView:(UIView *)view onTopLeft:(BOOL)tl topRight:(BOOL)tr bottomLeft:(BOOL)bl bottomRight:(BOOL)br radius:(float)radius {
    
    if (tl || tr || bl || br) {
        UIRectCorner corner = 0;
        if (tl) {corner = corner | UIRectCornerTopLeft;}
        if (tr) {corner = corner | UIRectCornerTopRight;}
        if (bl) {corner = corner | UIRectCornerBottomLeft;}
        if (br) {corner = corner | UIRectCornerBottomRight;}
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.frame = view.bounds;
        maskLayer.path = maskPath.CGPath;
        view.layer.mask = maskLayer;
    }
}

@end
