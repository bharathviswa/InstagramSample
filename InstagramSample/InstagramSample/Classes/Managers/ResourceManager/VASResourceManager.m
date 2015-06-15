//
//  VASNetworkManager.m
//  InstagramSample
//
//  Created by Igor Vasilenko on 08/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "VASResourceManager.h"

#import "AFNetworking.h"
#import "SSKeychain.h"
#import "VASSessionManager.h"
#import "VASUser.h"
#import "VASMedia.h"

static NSString *const kUserInfoAPIUrl = @"users/%@";
static NSString *const kUserRecentMediaAPIMethod = @"users/%@/media/recent";
static NSString *const kUserSelfFeedAPIUrl = @"users/self/feed";

static NSString *const kMediaInfoAPIUrl = @"media/%@";
static NSString *const kPopularMediaAPIUrl = @"media/popular";

@interface VASResourceManager()

@property (nonatomic, strong) VASSessionManager *manager;

@end

@implementation VASResourceManager

- (instancetype)init
{
    if (self = [super init])
    {
        NSString *accessToken = [SSKeychain passwordForService:kKeychainServiceName
                                                       account:kKeychainAccountName];
        
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _manager = [[VASSessionManager alloc] initWithSessionConfiguration:sessionConfiguration
                                                                   baseURL:[NSURL URLWithString:kInstagramBaseAPIUrl]
                                                            baseParameters:@{@"access_token" : accessToken}];
    }
    return self;
}

#pragma mark - Users

- (NSURLSessionDataTask *)requestUserInfoWithID:(NSString *)userID
                                        success:(CompletionBlockWithSuccess)success
                                        failure:(CompletionBlockWithFailure)failure
{
    NSURLSessionDataTask *task = [self.manager method:VASHTTPMethodGET
                                            URLString:[NSString stringWithFormat:kUserInfoAPIUrl, userID]
                                           parameters:nil
                                          resultClass:[VASUser class]
                                               forKey:@"data"
                                              success:^(NSURLSessionDataTask *task, id responseObject) {
                                                  if (responseObject) {
                                                      success(responseObject);
                                                  }
                                              } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                  if (error) {
                                                      failure(error);
                                                  }
                                              }];
    [task resume];
    
    return task;
}

- (NSURLSessionDataTask *)requestRecentUserMediaListWithID:(NSString *)userID
                                                   success:(CompletionBlockWithSuccess)success
                                                   failure:(CompletionBlockWithFailure)failure
{
    NSURLSessionDataTask *task = [self.manager method:VASHTTPMethodGET
                                            URLString:[NSString stringWithFormat:kUserRecentMediaAPIMethod, userID]
                                           parameters:nil
                                          resultClass:[VASMedia class]
                                               forKey:@"data"
                                              success:^(NSURLSessionDataTask *task, id responseObject) {
                                                  if (responseObject) {
                                                      success(responseObject);
                                                  }
                                              } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                  if (error) {
                                                      failure(error);
                                                  }
                                              }];
    [task resume];
    
    return task;
}

- (NSURLSessionDataTask *)requestSelfMediaFeedListWithSuccess:(CompletionBlockWithSuccess)success
                                                      failure:(CompletionBlockWithFailure)failure
{
    NSURLSessionDataTask *task = [self.manager method:VASHTTPMethodGET
                                            URLString:kUserSelfFeedAPIUrl
                                           parameters:nil
                                          resultClass:[VASMedia class]
                                               forKey:@"data"
                                              success:^(NSURLSessionDataTask *task, id responseObject) {
                                                  if (responseObject) {
                                                      success(responseObject);
                                                  }
                                              } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                  if (error) {
                                                      failure(error);
                                                  }
                                              }];
    [task resume];
    
    return task;
}

#pragma mark - Media

- (NSURLSessionDataTask *)requestMediaInfoWithID:(NSString *)mediaID
                                         success:(CompletionBlockWithSuccess)success
                                         failure:(CompletionBlockWithFailure)failure
{
    NSURLSessionDataTask *task = [self.manager method:VASHTTPMethodGET
                                            URLString:[NSString stringWithFormat:kMediaInfoAPIUrl, mediaID]
                                           parameters:nil
                                          resultClass:[VASMedia class]
                                               forKey:@"data"
                                              success:^(NSURLSessionDataTask *task, id responseObject) {
                                                  if (responseObject) {
                                                      success(responseObject);
                                                  }
                                              } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                  if (error) {
                                                      failure(error);
                                                  }
                                              }];
    [task resume];
    
    return task;
}

- (NSURLSessionDataTask *)requestPopularMediaListWithSuccess:(CompletionBlockWithSuccess)success
                                                     failure:(CompletionBlockWithFailure)failure
{
    NSURLSessionDataTask *task = [self.manager method:VASHTTPMethodGET
                                            URLString:kPopularMediaAPIUrl
                                           parameters:nil
                                          resultClass:[VASMedia class]
                                               forKey:@"data"
                                              success:^(NSURLSessionDataTask *task, id responseObject) {
                                                  if (responseObject) {
                                                      success(responseObject);
                                                  }
                                              } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                  if (error) {
                                                      failure(error);
                                                  }
                                              }];
    [task resume];
    
    return task;
}

@end
