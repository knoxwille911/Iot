//
//  IotServerProvider.m
//  SpeedTest
//
//  Created by Dmtech on 19.03.18.
//  Copyright © 2018 Dmtech. All rights reserved.
//

#import "IotServerProvider.h"
#import "IotNetworkController.h"
#import "IotEndpoints.h"
#import "IotWrapperDTO.h"
#import "IotXDKDTO.h"
#import "IotBulbDTO.h"

static const BOOL kIotUseOfflineDevicesList = NO;

static const NSString *kIotServerProviderDeviceIDKey = @"deviceID";
static const NSString *kIotServerProviderBulbIDKey = @"bulbId";

static const NSString *kIotServerProviderBulbRedColor   = @"red";
static const NSString *kIotServerProviderBulbGreenColor = @"green";
static const NSString *kIotServerProviderBulbBlurColor  = @"blue";

static const NSString *kIotServerProviderConversationQuestionKey  = @"q";

@interface IotServerProvider()

@property (nonatomic, strong) id<IotServerProviderInjection> injection;
@property (nonatomic, strong) NSString *deviceID;

@end

@implementation IotServerProvider

-(instancetype)initWithInjection:(id<IotServerProviderInjection>)injection {
    if (self = [super init]) {
        self.injection = injection;
        self.deviceID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    }
    return self;
}

-(void)turnOnPowerBulbWithBulbId:(NSString *)bulbID withCompletion:(IotServerProviderProtocolSimpleCompletionHandler)completion {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:bulbID, kIotServerProviderBulbIDKey, nil];
    [self.injection.networkController postAsFormData:[IotEndpoints turnOnPowerBulbEndpoint] withParams:params shouldIncludeAuthToken:YES withCompletionHandler:^(NSObject *response, NSError *error) {
        if (completion) {
            if (error) {
                completion(NO);
            }
            else {
                completion(YES);
            }
        }
    }];
}


-(void)turnOffPowerBulbWithBulbId:(NSString *)bulbID withCompletion:(IotServerProviderProtocolSimpleCompletionHandler)completion {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:bulbID, kIotServerProviderBulbIDKey, nil];
    [self.injection.networkController postAsFormData:[IotEndpoints turnOffPowerBulbEndpoint] withParams:params shouldIncludeAuthToken:YES withCompletionHandler:^(NSObject *response, NSError *error) {
        if (completion) {
            if (error) {
                completion(NO);
            }
            else {
                completion(YES);
            }
        }
    }];
}


-(void)changeColorOfBulbWithBulbId:(NSString *)bulbID color:(UIColor *)color withCompletion:(IotServerProviderProtocolSimpleCompletionHandler)completion {
    
    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha =0.0;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    
    NSInteger redInt = (NSInteger)(red * 255.0f);
    NSInteger greenInt = (NSInteger)(green * 255.0f);
    NSInteger blueInt = (NSInteger)(blue * 255.0f);
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:bulbID, kIotServerProviderBulbIDKey,
                            @(redInt), kIotServerProviderBulbRedColor,
                            @(greenInt), kIotServerProviderBulbGreenColor,
                            @(blueInt), kIotServerProviderBulbBlurColor,
                            nil];
    [self.injection.networkController postAsFormData:[IotEndpoints changeColorOfBulbEndpoint] withParams:params shouldIncludeAuthToken:YES withCompletionHandler:^(NSObject *response, NSError *error) {
        if (completion) {
            if (error) {
                completion(NO);
            }
            else {
                completion(YES);
            }
        }
    }];
}


-(void)returnDefaultStateOfBulbWithId:(NSString *)bulbID withCompletion:(IotServerProviderProtocolSimpleCompletionHandler)completion; {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:bulbID, kIotServerProviderBulbIDKey, nil];
    [self.injection.networkController postAsFormData:[IotEndpoints returnDefaultStateOfBulbEndpoint] withParams:params shouldIncludeAuthToken:YES withCompletionHandler:^(NSObject *response, NSError *error) {
        if (completion) {
            if (error) {
                completion(NO);
            }
            else {
                completion(YES);
            }
        }
    }];
}


-(void)turnOnNightStateOfBulbWithBulbId:(NSString *)bulbID withCompletion:(IotServerProviderProtocolSimpleCompletionHandler)completion; {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:bulbID, kIotServerProviderBulbIDKey, nil];
    [self.injection.networkController postAsFormData:[IotEndpoints turnOnNightStateOfBulbEndpoint] withParams:params shouldIncludeAuthToken:YES withCompletionHandler:^(NSObject *response, NSError *error) {
        if (completion) {
            if (error) {
                completion(NO);
            }
            else {
                completion(YES);
            }
        }
    }];
}


-(void)turnOffNightStateOfBulbWithBulbId:(NSString *)bulbID withCompletion:(IotServerProviderProtocolSimpleCompletionHandler)completion; {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:bulbID, kIotServerProviderBulbIDKey, nil];
    [self.injection.networkController postAsFormData:[IotEndpoints turnOffNightStateOfBulbEndpoint] withParams:params shouldIncludeAuthToken:YES withCompletionHandler:^(NSObject *response, NSError *error) {
        if (completion) {
            if (error) {
                completion(NO);
            }
            else {
                completion(YES);
            }
        }
    }];
}


-(void)getInfoOfBulbWithBulbId:(NSString *)bulbID withCompletionHandler:(IotServerProviderProtocolObjectsCompletionHandler)handler {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:bulbID, kIotServerProviderBulbIDKey, nil];
    [self.injection.networkController get:[IotEndpoints getInfoOfBulbEndpoint] withParams:params shouldIncludeAuthToken:YES withCompletionHandler:^(NSObject *response, NSError *error) {
        NSError *parseError;
        IotBulbDTO *bublDTO = [MTLJSONAdapter modelOfClass:[IotBulbDTO class] fromJSONDictionary:(NSDictionary *)response error:&parseError];
        if (handler && bublDTO) {
            handler(@[bublDTO]);
        }
    }];
}

-(void)getAllDevicesWithCompletionHandler:(IotServerProviderProtocolObjectsCompletionHandler)handler {
    if (kIotUseOfflineDevicesList) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Configuration" ofType:@"json"];
        
        NSError *error;
        NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
        NSError *parseError;
        IotWrapperDTO *wrapperDTO = [MTLJSONAdapter modelOfClass:[IotWrapperDTO class] fromJSONDictionary:jsonDict error:&parseError];
        if (handler && wrapperDTO) {
            NSMutableArray *array = [NSMutableArray arrayWithArray:wrapperDTO.wrapperbulbList];
            [array addObjectsFromArray:wrapperDTO.wrapperXdkList];
            handler(array);
        }
    }
    else {
        [self.injection.networkController getNoParams:[IotEndpoints getAllDevicesEndpoint] shouldIncludeAuthToken:YES withCompletionHandler:^(NSObject *response, NSError *error) {
            NSError *parseError;
            IotWrapperDTO *wrapperDTO = [MTLJSONAdapter modelOfClass:[IotWrapperDTO class] fromJSONDictionary:(NSDictionary *)response error:&parseError];
            if (handler && wrapperDTO) {
                NSMutableArray *array = [NSMutableArray arrayWithArray:wrapperDTO.wrapperbulbList];
                [array addObjectsFromArray:wrapperDTO.wrapperXdkList];
                handler(array);
            }
        }];
    }
}


-(void)getXDKdeviceWithID:(NSString *)deviceID {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:kIotServerProviderDeviceIDKey, deviceID, nil];
    [self.injection.networkController get:[IotEndpoints getXDKdeviceEndpoint] withParams:params shouldIncludeAuthToken:YES withCompletionHandler:^(NSObject *response, NSError *error) {
        
    }];
}


-(void)getConversationAnswerForQuestion:(NSString *)question {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:kIotServerProviderConversationQuestionKey, question, nil];
    [self.injection.networkController postAsFormData:[IotEndpoints getConversationAnswerEndpoint] withParams:params shouldIncludeAuthToken:YES withCompletionHandler:^(NSObject *response, NSError *error) {
        
    }];
}

@end
