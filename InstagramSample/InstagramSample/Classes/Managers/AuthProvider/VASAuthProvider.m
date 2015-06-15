//
//  VASAuthProvider.m
//  InstagramSample
//
//  Created by Igor Vasilenko on 14/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "VASAuthProvider.h"

#import "VASSessionManager.h"
#import <AFNetworking/AFURLRequestSerialization.h>
#import "VASAuthenticationConfigurator.h"

@interface VASAuthProvider()

@property (nonatomic, strong) VASSessionManager *sessionManager;

@end

@implementation VASAuthProvider

#pragma mark - Initialize

- (instancetype)initWithAuthenticationConfigurator:(VASAuthenticationConfigurator *)configurator;
{
    if (self = [super init]) {
        
        _configurator = configurator;

        _sessionManager = [[VASSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                                          baseURL:[NSURL URLWithString:self.configurator.requestTokenUrl]
                                                                   baseParameters:self.configurator.requestTokenBaseParameters];
    }
    return self;
}

#pragma mark - Properties

- (NSURLRequest *)authUrlRequest
{
    return [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET"
                                                         URLString:self.configurator.authorizeUrl
                                                        parameters:self.configurator.authenticateBaseParameters
                                                             error:NULL];
}

#pragma mark - Access Token Request

- (void)requestAccessTokenWithResponseCode:(NSString *)responseCode
                                   success:(AuthProviderCompletionBlockWithSuccess)success
                                   failure:(AuthProviderCompletionBlockWithFailure)failure
{
    NSURLSessionDataTask *task = [self.sessionManager method:VASHTTPMethodPOST
                                                   URLString:nil
                                                  parameters:@{
                                                               @"code" : responseCode
                                                               }
                                                     success:^(NSURLSessionDataTask *task, id responseObject) {
                                                         if (responseObject) {
                                                             NSString *accessToken = responseObject[@"access_token"];
                                                             if (accessToken) {
                                                                 success(task, accessToken);
                                                             }
                                                         }
                                                         else
                                                         {
                                                             success(task, responseObject);
                                                         }
                                                     }
                                                     failure:failure];
    [task resume];
}

@end
