//
//  VASNetworkRequestManager.h
//  InstagramSample
//
//  Created by Igor Vasilenko on 09/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFHTTPRequestOperation;

typedef void(^NetworkRequestCompletionBlockWithSuccess)(id responseObject);
typedef void(^NetworkRequestCompletionBlockWithFailure)(NSError *error);

@interface VASNetworkRequestManager : NSObject

#pragma mark - Initialize

- (instancetype)initWithBaseURL:(NSURL *)baseURL
          baseRequestParameters:(NSDictionary *)parameters;

#pragma mark - Request's

- (NSURLSessionDataTask *)resumeTaskWithGetRequestWithMethod:(NSString *)method
                                                  parameters:(id)parameters
                                                 resultClass:(Class)resultClass
                                                     success:(NetworkRequestCompletionBlockWithSuccess)success
                                                     failure:(NetworkRequestCompletionBlockWithFailure)failure;

- (AFHTTPRequestOperation *)sendGetRequestWithMethod:(NSString *)method
                                          parameters:(id)parameters
                                         resultClass:(Class)resultClass
                                             success:(NetworkRequestCompletionBlockWithSuccess)success
                                             failure:(NetworkRequestCompletionBlockWithFailure)failure;

@end
