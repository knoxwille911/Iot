//
//  IotConversationDetailTextBubbleView.m
//  Iot
//
//  Created by Dmtech on 10.04.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

#import "IotConversationDetailTextBubbleView.h"
#import "IotConversationDetailMessageUIInfo.h"

static const UIEdgeInsets kIotConversetionDetailTextViewBubbleInset = {13, 13, 13, 13};

CGFloat kBubbleTextSize = 18.0f;

@interface IotConversationDetailTextBubbleView () {
    
}

@property (nonatomic, retain) UITextView *textView;

@end

@implementation IotConversationDetailTextBubbleView

-(instancetype)initWithData:(IotConversationDetailMessageUIInfo *)params {
    if (self = [super initWithData:params]) {
        
    }
    return self;
}


-(void)setupViewWithdata:(IotConversationDetailMessageUIInfo *)params {
    [super setupViewWithdata:params];
    
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(kIotConversetionDetailTextViewBubbleInset.left,
                                                                kIotConversetionDetailTextViewBubbleInset.top,
                                                                CGRectGetWidth(self.frame) - kIotConversetionDetailTextViewBubbleInset.left - kIotConversetionDetailTextViewBubbleInset.right,
                                                                CGRectGetHeight(self.frame) - kIotConversetionDetailTextViewBubbleInset.top - kIotConversetionDetailTextViewBubbleInset.bottom)];
    self.textView.textContainer.lineFragmentPadding = 0;
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithAttributedString:params.message];
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:kBubbleTextSize]};
    [attrString addAttributes:attributes range:NSMakeRange(0, params.message.length)];
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, attrString.length)];
    
    self.textView.attributedText = attrString;
    self.textView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.editable = NO;
    self.textView.scrollEnabled = NO;
    self.textView.dataDetectorTypes = UIDataDetectorTypeAll;
    [self addSubview:self.textView];
    self.backgroundColor = UIColor.clearColor;
    //    [self.textView autoresizesSubviews];
}


+(UIEdgeInsets)bubbleViewContentInset {
    return kIotConversetionDetailTextViewBubbleInset;
}


+(CGSize)bubbleSizeForData:(IotConversationDetailMessageUIInfo *)params {
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithAttributedString:params.message];
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:kBubbleTextSize]};
    [attrString addAttributes:attributes range:NSMakeRange(0, params.message.length)];
    CGRect rect = [attrString boundingRectWithSize:CGSizeMake(kIotConversationDetailMaxBubbleWidth - kIotConversetionDetailTextViewBubbleInset.left - kIotConversetionDetailTextViewBubbleInset.right, 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    
    return CGSizeMake(ceil(rect.size.width), ceil(rect.size.height));
}
@end
