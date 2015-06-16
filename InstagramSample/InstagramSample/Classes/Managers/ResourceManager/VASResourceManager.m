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
#import "VASAPIConfigurator.h"

// Users methods

static NSString *const kUserInfoAPIUrl = @"users/%@";
static NSString *const kUserRecentMediaAPIMethod = @"users/%@/media/recent";
static NSString *const kUserSelfFeedAPIUrl = @"users/self/feed";
static NSString *const kUserFollowsList = @"users/%@/follows";
static NSString *const kUserFollowedByList = @"users/%@/followed-by";

// Media methods

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
        VASAPIConfigurator *configuratorAPI = [VASAPIConfigurator baseConfigurator];
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _manager = [[VASSessionManager alloc] initWithSessionConfiguration:sessionConfiguration
                                                          configurationAPI:configuratorAPI];
    }
    return self;
}

#pragma mark - Users

- (NSURLSessionDataTask *)userInfoWithID:(NSString *)userID
                                 success:(ResourceManagerCompletionBlockWithSuccess)success
                                 failure:(ResourceManagerCompletionBlockWithFailure)failure
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

- (NSURLSessionDataTask *)recentUserMediaListWithID:(NSString *)userID
                                            success:(ResourceManagerCompletionBlockWithSuccess)success
                                            failure:(ResourceManagerCompletionBlockWithFailure)failure
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

- (NSURLSessionDataTask *)selfMediaFeedListWithSuccess:(ResourceManagerCompletionBlockWithSuccess)success
                                               failure:(ResourceManagerCompletionBlockWithFailure)failure
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

- (NSURLSessionDataTask *)userFollowsListWithID:(NSString *)userID
                                        success:(ResourceManagerCompletionBlockWithSuccess)success
                                        failure:(ResourceManagerCompletionBlockWithFailure)failure
{
    NSURLSessionDataTask *task = [self.manager method:VASHTTPMethodGET
                                            URLString:kUserFollowsList
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

- (NSURLSessionDataTask *)userFollowedByListWithID:(NSString *)userID
                                           success:(ResourceManagerCompletionBlockWithSuccess)success
                                           failure:(ResourceManagerCompletionBlockWithFailure)failure
{
    NSURLSessionDataTask *task = [self.manager method:VASHTTPMethodGET
                                            URLString:kUserFollowedByList
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

#pragma mark - Media

- (NSURLSessionDataTask *)mediaInfoWithID:(NSString *)mediaID
                                  success:(ResourceManagerCompletionBlockWithSuccess)success
                                  failure:(ResourceManagerCompletionBlockWithFailure)failure
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

- (NSURLSessionDataTask *)popularMediaListWithSuccess:(ResourceManagerCompletionBlockWithSuccess)success
                                              failure:(ResourceManagerCompletionBlockWithFailure)failure
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
