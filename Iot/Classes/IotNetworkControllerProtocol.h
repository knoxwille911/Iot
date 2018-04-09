//
//  PCNetworkServiceProtocol.h
//  PEN
//
//  Created by Dmtech on 11.09.17.
//  Copyright © 2017 DarkMatterAB. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IotNetworkError;

typedef void (^NetworkRequestCompletionHandler) (NSObject *response, NSError *error);

@protocol IotNetworkControllerProtocol

/**
 * performs a POST request
 *
 * @param NSString urlString                            URL used on the request
 * @param NSDictionary params                           request parameters
 * @param NetworkRequestCompletionHandler               block used to handle the network communication
 *
 */
- (void)post:(NSString *)urlString withParams:(id<NSObject> )params shouldIncludeAuthToken:(BOOL)authToken withCompletionHandler:(NetworkRequestCompletionHandler)completionHandler;

/**
 *  performs a GET request
 *
 *  @param urlString         URL used on the request
 *  @param params            request parameters
 *  @param completionHandler block used to handle the network communication
 */
- (void)get:(NSString *)urlString withParams:(NSDictionary *)params shouldIncludeAuthToken:(BOOL)authToken withCompletionHandler:(NetworkRequestCompletionHandler)completionHandler;


- (void)getNoParams:(NSString *)urlString shouldIncludeAuthToken:(BOOL)authToken withCompletionHandler:(NetworkRequestCompletionHandler)completionHandler;

/**
 *  performs a DELETE request
 *
 *  @param urlString         URL used on the request
 *  @param params            request parameters
 *  @param completionHandler block used to handle the network communication
 */
- (void)deleteWithURL:(NSString *)urlString withParams:(NSDictionary *)params shouldIncludeAuthToken:(BOOL)authToken withCompletionHandler:(NetworkRequestCompletionHandler)completionHandler;

/**
 *  performs a PUT request
 *
 *  @param urlString         URL used on the request
 *  @param params            request parameters
 *  @param completionHandler block used to handle the network communication
 */
- (void)put:(NSString *)urlString withParams:(NSDictionary *)params shouldIncludeAuthToken:(BOOL)authToken withCompletionHandler:(NetworkRequestCompletionHandler)completionHandler;


- (void)putArray:(NSString *)urlString withParams:(NSArray *)params shouldIncludeAuthToken:(BOOL)authToken withCompletionHandler:(NetworkRequestCompletionHandler)completionHandler;
/**
 * performs a POST request (as form data)
 * @todo remove this and abstract in post:withParams:withCompletionHandler
 *
 * @param NSString urlString                            URL used on the request
 * @param NSDictionary params                           request parameters
 * @param NetworkRequestCompletionHandler               block used to handle the network communication
 *
 */

- (void)postAsFormData:(NSString *)urlString withParams:(NSDictionary *)params shouldIncludeAuthToken:(BOOL)authToken withCompletionHandler:(NetworkRequestCompletionHandler)completionHandler;

//TODO DOCS
- (void)postSms:(NSString *)urlString withParams:(NSDictionary *)params withCompletionHandler:(NetworkRequestCompletionHandler)completionHandler;

- (NSString *)addAppVersionToURL:(NSString *)url;

/**
 * Display Alert if no internet connection on context
 *
 * @pram UIViewController context                       context to display alert
 * @return true if internet false if not
 */
- (BOOL)isInternetConnectedWithAlert:(UIViewController*)context;

- (void)tokenPost:(NSString *)urlString
       withParams:(NSDictionary *)params
withCompletionHandler:(NetworkRequestCompletionHandler)completionHandler;

@end
