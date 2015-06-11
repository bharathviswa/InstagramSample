//
//  VASNetworkRequestManager.h
//  InstagramSample
//
//  Created by Igor Vasilenko on 09/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^NetworkRequestCompletionBlockWithSuccess)(id responseObject);
typedef void(^NetworkRequestCompletionBlockWithFailure)(NSError *error);

@interface VASNetworkRequestManager : NSObject

#pragma mark - Initialize

- (instancetype)initWithBaseURL:(NSURL *)baseURL
          baseRequestParameters:(NSDictionary *)parameters;

#pragma mark - Request's

- (NSURLSessionDataTask *)sendGetRequestWithMethod:(NSString *)method
                                        parameters:(NSDictionary *)parameters
                                       resultClass:(Class)resultClass
                                           success:(NetworkRequestCompletionBlockWithSuccess)success
                                           failure:(NetworkRequestCompletionBlockWithFailure)failure;

@end
