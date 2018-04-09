//
//  IotConversationAnswerOutDTO.m
//  Iot
//
//  Created by Dmtech on 06.04.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

#import "IotConversationAnswerOutDTO.h"

@implementation IotConversationAnswerOutDTO

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return  @{
                @keypath(IotConversationAnswerOutDTO.new, text)  : @"text"
               };
}

@end
