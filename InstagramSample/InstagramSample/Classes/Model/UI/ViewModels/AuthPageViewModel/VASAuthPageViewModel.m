//
//  VASAuthPageViewModel.m
//  InstagramSample
//
//  Created by Igor Vasilenko on 14/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "VASAuthPageViewModel.h"

#import "VASAuthProvider.h"
#import "SSKeychain.h"

@interface VASAuthPageViewModel()

@property (nonatomic, strong) VASAuthProvider *authProvider;

@end

@implementation VASAuthPageViewModel

- (instancetype)init
{
    if (self = [super init])
    {
        _authProvider = [[VASAuthProvider alloc] initWithBaseURL:[NSURL URLWithString:kInstagramAuthToken]
                                                        clientID:kInstagramAPIClientID
                                                    clientSecret:kInstagramAPIClientSecret];
    }
    return self;
}

- (NSURLRequest *)authUrlRequest
{
    return self.authProvider.authUrlRequest;
}

- (void)requestAccessTokenWithResponseCode:(NSString *)responseCode
                                   success:(AuthPageViewModelCompletionBlockWithSuccess)success
                                   failure:(AuthPageViewModelCompletionBlockWithFailure)failure
{
    [self.authProvider requestAccessTokenWithResponseCode:responseCode
                                                  success:^(NSURLSessionDataTask *task, NSString *accessToken) {
                                                      if (accessToken) {
                                                          [SSKeychain setPassword:accessToken
                                                                       forService:kKeychainServiceName
                                                                          account:kKeychainAccountName];
                                                          success(YES);
                                                      }
                                                  } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                      if (error) {
                                                          failure(error);
                                                      }
                                                  }];
}

@end
