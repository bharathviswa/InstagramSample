//
//  VASAuthPageViewModel.m
//  InstagramSample
//
//  Created by Igor Vasilenko on 14/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "VASAuthPageViewModel.h"

#import "VASAuthenticationProvider.h"
#import "SSKeychain.h"
#import "VASAuthenticationConfigurator.h"

@interface VASAuthPageViewModel()

@property (nonatomic, strong) VASAuthenticationProvider *authProvider;

@end

@implementation VASAuthPageViewModel

- (instancetype)init
{
    if (self = [super init])
    {
        _authProvider = [[VASAuthenticationProvider alloc] initWithAuthenticationConfigurator:[VASAuthenticationConfigurator defaultConfigurator]];
    }
    return self;
}

- (NSURLRequest *)authenticationURLRequest
{
    return self.authProvider.authenticationURLRequest;
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
                                                      else
                                                      {
                                                          success(NO);
                                                      }
                                                  } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                      if (error) {
                                                          failure(error);
                                                      }
                                                  }];
}

@end
