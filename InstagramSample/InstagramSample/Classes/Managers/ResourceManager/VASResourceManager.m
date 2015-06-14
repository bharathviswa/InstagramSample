//
//  VASNetworkManager.m
//  InstagramSample
//
//  Created by Igor Vasilenko on 08/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "VASResourceManager.h"

#import "AFNetworking.h"
#import "VASSessionManager.h"
#import "VASUser.h"
#import "VASMedia.h"

static NSString *const kUserInfoAPIUrl = @"users/%@/";
static NSString *const kUserRecentMediaAPIMethod = @"users/%@/media/recent";

@interface VASResourceManager()

@property (nonatomic, strong) VASSessionManager *manager;

@end

@implementation VASResourceManager

- (instancetype)init
{
    if (self = [super init])
    {
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _manager = [[VASSessionManager alloc] initWithSessionConfiguration:sessionConfiguration
                                                                   baseURL:[NSURL URLWithString:kInstagramBaseAPIUrl]
                                                            baseParameters:@{@"client_id" : kInstagramAPIClientID}];
    }
    return self;
}

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

@end
