//
//  VASAuthenticationProvider.h
//  InstagramSample
//
//  Created by Igor Vasilenko on 14/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VASAPIConfigurator;

typedef void(^AuthProviderCompletionBlockWithSuccess)(NSURLSessionDataTask *task, id responseObject);
typedef void(^AuthProviderCompletionBlockWithFailure)(NSURLSessionDataTask *task, NSError *error);

@interface VASAuthenticationProvider : NSObject

@property (nonatomic, strong) NSURLRequest *authenticationURLRequest;

#pragma mark - Initialize

- (instancetype)initWithAuthenticationConfigurator:(VASAPIConfigurator *)configurator;

#pragma mark - Access Token Request

- (void)requestAccessTokenWithResponseCode:(NSString *)responseCode
                                   success:(AuthProviderCompletionBlockWithSuccess)success
                                   failure:(AuthProviderCompletionBlockWithFailure)failure;

@end
