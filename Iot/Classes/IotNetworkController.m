//
//  PCNetworkController.m
//  PEN
//
//  Created by Dmtech on 11.09.17.
//  Copyright © 2017 DarkMatterAB. All rights reserved.
//

#import "IotNetworkController.h"

@interface IotNetworkController ()

@property (nonatomic, strong) id<IotNetworkControllerInjection> injection;

@end


@implementation IotNetworkController

-(instancetype)initWithInjection:(id<IotNetworkControllerInjection>)injection {
    if (self = [super init]) {
        self.injection = injection;
    }
    return self;
}


- (void)makeRequest:(NSURLRequest *)request withCompletion:(NetworkRequestCompletionHandler)completion {
    NSLog(@"FULL: %@", request.URL.absoluteString);
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        id serializedData = nil;
        if (data != nil) {
            NSError *jsonError;
            serializedData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments | kNilOptions error:&jsonError];
            if([serializedData isKindOfClass:[NSDictionary class]] && serializedData != nil) {
                NSDictionary *jsonData = (NSDictionary*)serializedData;
                NSLog(@"========JSON DIC========");
                NSLog(@"%@", jsonData);
                
            } else if ([serializedData isKindOfClass:[NSNumber class]]) {
                completion(serializedData, nil);
                return;
            } else if (![serializedData isKindOfClass:[NSArray class]] && serializedData != nil) {
                NSLog(@"Unexpected response object!");
                completion(nil, error);
                return;
            }
            
        }
        if (error == nil) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*) response;
            completion(serializedData, nil);
        } else {
            completion(nil, error);
        }
    }];
    [dataTask resume];
}


- (void)post:(NSString *)urlString withParams:(id<NSObject> )params shouldIncludeAuthToken:(BOOL)authToken withCompletionHandler:(NetworkRequestCompletionHandler)completionHandler {
    NSLog(@"\n\n\n");
    
    NSLog(@"%@", urlString);
    
    NSString *fullUrl = [self fullURLForURL:urlString withAuthToken:authToken];
    
    NSLog(@"FULL: %@", fullUrl);
    NSLog(@"\n\n");
    NSLog(@"PARAMS: %@", params);
    NSLog(@"\n\n\n");
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:fullUrl]];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSError *error;
    
    NSData *rawData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = rawData;
    
    [self makeRequest:request withCompletion:completionHandler];
}

- (void)postAsFormData:(NSString *)urlString withParams:(NSDictionary *)params shouldIncludeAuthToken:(BOOL)authToken  withCompletionHandler:(NetworkRequestCompletionHandler)completionHandler {
    
    NSLog(@"%@", urlString);
    
    NSString *fullUrl = [self fullURLForURL:urlString withAuthToken:authToken];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:fullUrl]];
    request.HTTPMethod = @"POST";
    
    NSMutableString *getParameters = nil;
    NSString *processedParameteres = nil;
    
    if (params != nil) {
        
        getParameters = [[NSMutableString alloc] init];
        
        for (NSString *key in params) {
            
            [getParameters appendString:[NSString stringWithFormat:@"%@=%@&", key, [params objectForKey:key]]];
        }
        
        if ([params count] > 1) {
            
            processedParameteres = [getParameters substringToIndex:[getParameters length] - 1];
        } else {
            
            processedParameteres = getParameters;
        }
    }
    
    NSData *bodyData = [processedParameteres dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    [self makeRequest:request withCompletion:completionHandler];
}


/* THIS METHOD SHOULD ONLY BE CALLED BY PCOAuthWrapper*/

- (void)tokenPost:(NSString *)urlString withParams:(NSDictionary *)params withCompletionHandler:(NetworkRequestCompletionHandler)completionHandler {
    NSLog(@"\n\n\n");
    
    NSLog(@"%@", urlString);
    NSString *fullUrl = urlString;
    
    NSLog(@"FULL: %@", fullUrl);
    NSLog(@"\n\n\n");
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[self addAppVersionToURL:urlString]]];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSError *error;
    NSData *rawData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = rawData;
    
    [self makeRequest:request withCompletion:completionHandler];
}


- (void)get:(NSString *)urlString withParams:(NSDictionary *)params shouldIncludeAuthToken:(BOOL)authToken withCompletionHandler:(NetworkRequestCompletionHandler)completionHandler {
    
    NSMutableString *getParameters = nil;
    NSString *processedParameteres = nil;
    
    if (params != nil) {
        
        getParameters = [[NSMutableString alloc] init];
        
        
        for (NSString *key in params) {
            
            [getParameters appendString:[NSString stringWithFormat:@"&%@=%@", key, [params objectForKey:key]]];
            
        }
        
        processedParameteres = getParameters;
        
    }
    
    processedParameteres = [processedParameteres containsString:@"#"] ? [processedParameteres stringByReplacingOccurrencesOfString:@"#" withString:@"%23"] : processedParameteres;
    
    NSString *fullUrl = [self fullURLForURL:urlString withAuthToken:authToken];
    fullUrl = [NSString stringWithFormat:@"%@%@", fullUrl, processedParameteres ? processedParameteres : @""];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString: fullUrl]];
    request.HTTPMethod = @"GET";
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [self makeRequest:request withCompletion:completionHandler];
}

- (void)getNoParams:(NSString *)urlString shouldIncludeAuthToken:(BOOL)authToken withCompletionHandler:(NetworkRequestCompletionHandler)completionHandler {
    
    NSString *fullUrl = [self fullURLForURL:urlString withAuthToken:authToken];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", fullUrl]]];
    request.HTTPMethod = @"GET";
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [self makeRequest:request withCompletion:completionHandler];
}


- (NSString *)addAppVersionToURL:(NSString *)url {
    NSString * appVersionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    
    NSString *additionalString = [NSString stringWithFormat:@"%@platform=ios&appVersion=%@", [url containsString:@"?"] ? @"&" : @"?", appVersionString];
    
    return [url stringByAppendingString:additionalString];
}

#pragma mark - Helper methods (private)

- (void)putHTTPMethod:(NSString *)httpMethod
              withURL:(NSString *)urlString
           withParams:(NSArray *)params
shouldIncludeAuthToken:(BOOL)authToken
withCompletionHandler:(NetworkRequestCompletionHandler)completionHandler {
    
    NSLog(@"%@", urlString);
    
    NSString *fullUrl = [self fullURLForURL:urlString withAuthToken:authToken];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:fullUrl]];
    request.HTTPMethod = httpMethod.uppercaseString;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    if (params) {
        NSError *error;
        NSData *rawData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];
        request.HTTPBody = rawData;
    }
    
    [self makeRequest:request withCompletion:completionHandler];
}

- (void)putOrDeleteWithHTTPMethod:(NSString *)httpMethod
                          withURL:(NSString *)urlString
                       withParams:(NSDictionary *)params
           shouldIncludeAuthToken:(BOOL)authToken
            withCompletionHandler:(NetworkRequestCompletionHandler)completionHandler {
    
    NSLog(@"%@", urlString);
    
    NSString *fullUrl = [self fullURLForURL:urlString withAuthToken:authToken];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:fullUrl]];
    request.HTTPMethod = httpMethod.uppercaseString;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    if (params && [params isKindOfClass:[NSDictionary class]]) {
        NSError *error;
        NSData *rawData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];
        request.HTTPBody = rawData;
    }
    else {
        NSString *str = (NSString *)params;
        NSData *rawData = [str dataUsingEncoding:NSUTF8StringEncoding];
        request.HTTPBody = rawData;
    }
    [self makeRequest:request withCompletion:completionHandler];
}


-(NSString *)fullURLForURL:(NSString *)url withAuthToken:(BOOL)authToken {
    NSString *fullUrl = url;
    fullUrl = [self replaceCharactersForServerInString:fullUrl];
    fullUrl = [self addAppVersionToURL:fullUrl];
    return fullUrl;
}

#pragma mark - Helper methods (private)

- (NSString *)replaceCharactersForServerInString:(NSString *)string {
    return string;
}


- (void)deleteWithURL:(NSString *)urlString withParams:(NSDictionary *)params shouldIncludeAuthToken:(BOOL)authToken withCompletionHandler:(NetworkRequestCompletionHandler)completionHandler {
    
    [self putOrDeleteWithHTTPMethod:@"DELETE"
                            withURL:urlString
                         withParams:params
             shouldIncludeAuthToken:authToken
              withCompletionHandler:completionHandler];
}


- (void)put:(NSString *)urlString withParams:(NSDictionary *)params shouldIncludeAuthToken:(BOOL)authToken withCompletionHandler:(NetworkRequestCompletionHandler)completionHandler {
    
    [self putOrDeleteWithHTTPMethod:@"PUT"
                            withURL:urlString
                         withParams:params
             shouldIncludeAuthToken:authToken
              withCompletionHandler:completionHandler];
}


- (void)putArray:(NSString *)urlString withParams:(NSArray *)params shouldIncludeAuthToken:(BOOL)authToken withCompletionHandler:(NetworkRequestCompletionHandler)completionHandler {
    
    [self putHTTPMethod:@"PUT"
                withURL:urlString
             withParams:params
 shouldIncludeAuthToken:authToken
  withCompletionHandler:completionHandler];
}

@end
