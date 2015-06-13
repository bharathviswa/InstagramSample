//
//  VASNetworkManager.m
//  InstagramSample
//
//  Created by Igor Vasilenko on 08/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "VASResourceManager.h"

#import "AFNetworking.h"
#import "VASNetworkRequestManager.h"
#import "VASUser.h"
#import "VASMedia.h"

static NSString *const kUserRecentMediaAPIMethod = @"media/recent";

@interface VASResourceManager()

@property (nonatomic, strong) VASNetworkRequestManager *manager;

@end

@implementation VASResourceManager

- (instancetype)init
{
    if (self = [super init])
    {
        _manager = [[VASNetworkRequestManager alloc] initWithBaseURL:[NSURL URLWithString:kInstagramBaseAPIUrl]
                                               baseRequestParameters:@{
                                                                       @"client_id" : kInstagramAPIClientID
                                                                       }];
    }
    return self;
}

- (void)requestUserInfoWithSuccess:(CompletionBlockWithSuccess)success
                           failure:(CompletionBlockWithFailure)failure
{
    [self.manager resumeTaskWithGetRequestWithMethod:nil
                                          parameters:nil
                                         resultClass:[VASUser class]
                                             success:^(id responseObject) {
                                                 if (responseObject) {
                                                     success(responseObject);
                                                 }
                                             } failure:^(NSError *error) {
                                                 if (error) {
                                                     failure(error);
                                                 }
                                             }];
//    [self.manager sendGetRequestWithMethod:nil
//                                parameters:nil
//                               resultClass:[VASUser class]
//                                   success:^(id responseObject) {
//                                       if (responseObject) {
//                                           if (success)
//                                               success(responseObject);
//                                       }
//                                   }
//                                   failure:^(NSError *error) {
//                                       
//                                   }];
}

- (void)requestRecentUserMediaListWithSuccess:(CompletionBlockWithSuccess)success
                                      failure:(CompletionBlockWithFailure)failure
{
    [self.manager resumeTaskWithGetRequestWithMethod:kUserRecentMediaAPIMethod
                                          parameters:nil
                                         resultClass:[VASMedia class]
                                             success:^(id responseObject) {
                                                 if (responseObject) {
                                                     success(responseObject);
                                                 }
                                             } failure:^(NSError *error) {
                                                 if (error) {
                                                     failure(error);
                                                 }
                                             }];
//    [self.manager sendGetRequestWithMethod:kUserRecentMediaAPIMethod
//                                parameters:nil
//                               resultClass:[VASMedia class]
//                                   success:^(id responseObject) {
//                                       if (responseObject) {
//                                           if (success)
//                                               success(responseObject);
//                                       }
//                                   }
//                                   failure:^(NSError *error) {
//                                       
//                                   }];
}

@end
