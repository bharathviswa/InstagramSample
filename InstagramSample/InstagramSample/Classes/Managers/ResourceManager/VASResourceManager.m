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
#import "VASAPIConfigurator.h"

static NSString *const kUserRecentMediaAPIMethod = @"media/recent";

@interface VASResourceManager()

@property (nonatomic, strong) VASNetworkRequestManager *manager;

@end

@implementation VASResourceManager

- (instancetype)init
{
    if (self = [super init])
    {
        VASAPIConfigurator *configurator = [[VASAPIConfigurator alloc] init];
        configurator.clientID = kInstagramAPIClientID;
        configurator.clientSecret = kInstagramAPIClientSecret;
        configurator.baseURL = [NSURL URLWithString:kInstagramBaseAPIUrl];
        
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
    [self.manager sendGetRequestWithMethod:nil
                                parameters:nil
                               resultClass:[VASUser class]
                                   success:^(id responseObject) {
                                       if (responseObject) {
                                           if (success)
                                               success(responseObject);
                                       }
                                   }
                                   failure:^(NSError *error) {
                                       
                                   }];
}

- (void)requestRecentUserMediaListWithSuccess:(CompletionBlockWithSuccess)success
                                      failure:(CompletionBlockWithFailure)failure
{
    [self.manager sendGetRequestWithMethod:kUserRecentMediaAPIMethod
                                parameters:nil
                               resultClass:[VASMedia class]
                                   success:^(id responseObject) {
                                       if (responseObject) {
                                           if (success)
                                               success(responseObject);
                                       }
                                   }
                                   failure:^(NSError *error) {
                                       
                                   }];
}

@end
