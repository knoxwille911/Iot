//
//  IotConversationAnswerOutDTO.h
//  Iot
//
//  Created by Dmtech on 06.04.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface IotConversationAnswerOutDTO : MTLModel<MTLJSONSerializing>

@property (nonatomic ,strong) NSString *text;

@end
