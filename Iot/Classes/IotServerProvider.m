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

-(void)turnOnPowerBulbWithBulbId:(NSString *)bulbID withCompletion:(IotServerProviderProtocolSimpleCompletionHandler)completion; {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:kIotServerProviderBulbIDKey, bulbID, nil];
    [self.injection.networkController post:[IotEndpoints turnOnPowerBulbEndpoint] withParams:params shouldIncludeAuthToken:YES withCompletionHandler:^(NSObject *response, NSError *error) {
        
    }];
}


-(void)turnOffPowerBulbWithBulbId:(NSString *)bulbID withCompletion:(IotServerProviderProtocolSimpleCompletionHandler)completion; {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:kIotServerProviderBulbIDKey, bulbID, nil];
    [self.injection.networkController post:[IotEndpoints turnOffPowerBulbEndpoint] withParams:params shouldIncludeAuthToken:YES withCompletionHandler:^(NSObject *response, NSError *error) {
        
    }];
}


-(void)changeColorOfBulbWithBulbId:(NSString *)bulbID red:(NSNumber *)red green:(NSNumber *)green blue:(NSNumber *)blue {

    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:kIotServerProviderBulbIDKey, bulbID,
                            kIotServerProviderBulbRedColor, red,
                            kIotServerProviderBulbGreenColor, green,
                            kIotServerProviderBulbBlurColor, blue,
                            nil];
    [self.injection.networkController post:[IotEndpoints changeColorOfBulbEndpoint] withParams:params shouldIncludeAuthToken:YES withCompletionHandler:^(NSObject *response, NSError *error) {
        
    }];
}


-(void)returnDefaultStateOfBulbWithId:(NSString *)bulbID withCompletion:(IotServerProviderProtocolSimpleCompletionHandler)completion; {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:kIotServerProviderBulbIDKey, bulbID, nil];
    [self.injection.networkController post:[IotEndpoints returnDefaultStateOfBulbEndpoint] withParams:params shouldIncludeAuthToken:YES withCompletionHandler:^(NSObject *response, NSError *error) {
        
    }];
}


-(void)turnOnNightStateOfBulbWithBulbId:(NSString *)bulbID withCompletion:(IotServerProviderProtocolSimpleCompletionHandler)completion; {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:kIotServerProviderBulbIDKey, bulbID, nil];
    [self.injection.networkController post:[IotEndpoints turnOnNightStateOfBulbEndpoint] withParams:params shouldIncludeAuthToken:YES withCompletionHandler:^(NSObject *response, NSError *error) {
        
    }];
}


-(void)turnOffNightStateOfBulbWithBulbId:(NSString *)bulbID withCompletion:(IotServerProviderProtocolSimpleCompletionHandler)completion; {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:kIotServerProviderBulbIDKey, bulbID, nil];
    [self.injection.networkController post:[IotEndpoints turnOffNightStateOfBulbEndpoint] withParams:params shouldIncludeAuthToken:YES withCompletionHandler:^(NSObject *response, NSError *error) {
        
    }];
}


-(void)getInfoOfBulbWithBulbId:(NSString *)bulbID withCompletionHandler:(IotServerProviderProtocolObjectsCompletionHandler)handler {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:kIotServerProviderBulbIDKey, bulbID, nil];
    [self.injection.networkController post:[IotEndpoints getInfoOfBulbEndpoint] withParams:params shouldIncludeAuthToken:YES withCompletionHandler:^(NSObject *response, NSError *error) {
        
    }];
}

-(void)getAllDevicesWithCompletionHandler:(IotServerProviderProtocolObjectsCompletionHandler)handler {
    [self.injection.networkController getNoParams:[IotEndpoints getAllDevicesEndpoint] shouldIncludeAuthToken:YES withCompletionHandler:^(NSObject *response, NSError *error) {
        NSError *parseError;
        IotWrapperDTO *wrapperDTO = [MTLJSONAdapter modelOfClass:[IotWrapperDTO class] fromJSONDictionary:(NSDictionary *)response error:&parseError];
        if (handler && wrapperDTO) {
            NSMutableArray *array = [NSMutableArray arrayWithArray:wrapperDTO.wrapperbulbList];
            [array addObjectsFromArray:wrapperDTO.wrapperXdkList];
//            array = [array arrayByAddingObjectsFromArray:wrapperDTO.wrapperXdkList];
            handler(array);
        }
    }];
}


-(void)getXDKdeviceWithID:(NSString *)deviceID {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:kIotServerProviderDeviceIDKey, deviceID, nil];
    [self.injection.networkController post:[IotEndpoints getXDKdeviceEndpoint] withParams:params shouldIncludeAuthToken:YES withCompletionHandler:^(NSObject *response, NSError *error) {
        
    }];
}


-(void)getConversationAnswerForQuestion:(NSString *)question {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:kIotServerProviderConversationQuestionKey, question, nil];
    [self.injection.networkController post:[IotEndpoints getConversationAnswerEndpoint] withParams:params shouldIncludeAuthToken:YES withCompletionHandler:^(NSObject *response, NSError *error) {
        
    }];
}

@end