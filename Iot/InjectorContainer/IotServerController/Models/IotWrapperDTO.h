//
//  IotWrapperDTO.h
//  Iot
//
//  Created by Dmtech on 06.04.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

#import <Mantle/Mantle.h>

@class IotXDKDTO;
@class IotBulbDTO;

@interface IotWrapperDTO : MTLModel<MTLJSONSerializing>

@property (nonatomic ,strong) NSArray<IotXDKDTO *> *wrapperXdkList;
@property (nonatomic ,strong) NSArray<IotBulbDTO *> *wrapperbulbList;

@end
