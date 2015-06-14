//
//  VASAuthProvider.h
//  InstagramSample
//
//  Created by Igor Vasilenko on 14/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^AuthProviderCompletionBlockWithSuccess)(NSURLSessionDataTask *task, id responseObject);
typedef void(^AuthProviderCompletionBlockWithFailure)(NSURLSessionDataTask *task, NSError *error);

@interface VASAuthProvider : NSObject

- (instancetype)initWithBaseURL:(NSURL *)baseURL
                       clientID:(NSString *)clientID
                   clientSecret:(NSString *)clientSecret;

- (void)requestAccessTokenWithResponseCode:(NSString *)responseCode
                                   success:(AuthProviderCompletionBlockWithSuccess)success
                                   failure:(AuthProviderCompletionBlockWithFailure)failure;

@end
