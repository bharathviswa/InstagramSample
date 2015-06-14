//
//  VASAuthProvider.m
//  InstagramSample
//
//  Created by Igor Vasilenko on 14/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "VASAuthProvider.h"

#import "VASSessionManager.h"

@interface VASAuthProvider()

@property (nonatomic, strong) NSURL *baseURL;
@property (nonatomic, strong) NSMutableDictionary *parameters;
@property (nonatomic, strong) VASSessionManager *sessionManager;

@end

@implementation VASAuthProvider

- (instancetype)initWithBaseURL:(NSURL *)baseURL
                       clientID:(NSString *)clientID
                   clientSecret:(NSString *)clientSecret
{
    if (self = [super init]) {
        _baseURL = baseURL;
        _parameters = [@{
                         @"client_id" : clientID,
                         @"client_secret" : clientSecret,
                         @"grant_type" : @"authorization_code",
                         @"redirect_uri" : kInstagramAPIRedirectUrl
                         } mutableCopy];
        
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        _sessionManager = [[VASSessionManager alloc] initWithSessionConfiguration:sessionConfig
                                                                          baseURL:_baseURL
                                                                   baseParameters:_parameters];
    }
    return self;
}

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
                                                     }
                                                     failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                         if (error) {
                                                             failure(task, error);
                                                         }
                                                     }];
    [task resume];
}

@end
