//
//  VASAuthProvider.m
//  InstagramSample
//
//  Created by Igor Vasilenko on 14/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "VASAuthenticationProvider.h"

#import "VASSessionManager.h"
#import <AFNetworking/AFURLRequestSerialization.h>
#import "VASAuthenticationConfigurator.h"
#import "VASUser.h"

@interface VASAuthenticationProvider()

@property (nonatomic, strong) VASSessionManager *manager;

@end

@implementation VASAuthenticationProvider

#pragma mark - Initialize

- (instancetype)initWithAuthenticationConfigurator:(VASAuthenticationConfigurator *)configurator;
{
    if (self = [super init]) {

        _configurator = configurator;
        
        _manager = [[VASSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                                   baseURL:[NSURL URLWithString:self.configurator.requestTokenURL]
                                                            baseParameters:self.configurator.requestTokenBaseParameters];
    }
    return self;
}

#pragma mark - Properties

- (NSURLRequest *)authenticationURLRequest
{
    return [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET"
                                                         URLString:self.configurator.authenticateURL
                                                        parameters:self.configurator.authenticateBaseParameters
                                                             error:NULL];
}

#pragma mark - Access Token Request

- (void)requestAccessTokenWithResponseCode:(NSString *)responseCode
                                   success:(AuthProviderCompletionBlockWithSuccess)success
                                   failure:(AuthProviderCompletionBlockWithFailure)failure
{
    NSURLSessionDataTask *task = [self.manager method:VASHTTPMethodPOST
                                            URLString:nil
                                           parameters:@{
                                                        @"code" : responseCode
                                                        }
                                              success:^(NSURLSessionDataTask *task, id responseObject) {
                                                  if (responseObject) {
                                                      NSString *accessToken = responseObject[@"access_token"];
                                                      
                                                      VASUser *user = [MTLJSONAdapter modelOfClass:[VASUser class]
                                                                                fromJSONDictionary:responseObject[@"user"]
                                                                                             error:NULL];
                                                      NSUserDefaults *UD = [NSUserDefaults standardUserDefaults];
                                                      [UD setObject:user.uid forKey:@"userID"];
                                                      [UD synchronize];
                                                      
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
