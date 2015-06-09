//
//  VASNetworkManager.m
//  InstagramSample
//
//  Created by Igor Vasilenko on 08/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "VASNetworkManager.h"

#import "AFNetworking.h"
#import "VASTemplateRequest.h"
#import "VASNetworkRequestManager.h"
#import "VASUser.h"
#import "VASMedia.h"

static NSString *const kUserRecentMediaAPIUrl = @"media/recent";

@interface VASNetworkManager()

@property (nonatomic, strong) VASNetworkRequestManager *requestManager;
@property (nonatomic, strong) VASTemplateRequest *baseTemplate;

@end

@implementation VASNetworkManager

+ (instancetype)sharedInstance
{
    static VASNetworkManager *sharedInstance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        
        sharedInstance.baseTemplate = [[VASTemplateRequest alloc] initWithBaseURL:[NSURL URLWithString:kInstagramBaseAPIUrl]];
        sharedInstance.requestManager = [[VASNetworkRequestManager alloc] initWithRequestTemplate:sharedInstance.baseTemplate];
    });
    return sharedInstance;
}

- (void)requestUserInfoWithSuccess:(UserInfoCompletionBlockWithSuccess)success
                           failure:(CompletionBlockWithFailure)failure
{
    [self.baseTemplate setResponseClass:[VASUser class]];
    
    [self.requestManager sendGETWithSuccess:^(id responseObject) {
        
        if (responseObject) {
            
            VASUser *user = responseObject;
            
            if (success)
                success(user);
        }
    } failure:^(NSError *error) {
        
        if (error) {
            if (failure)
                failure(error);
        }
    }];
}

- (void)requestRecentUserMediaListWithSuccess:(CompletionBlockWithSuccess)success
                                      failure:(CompletionBlockWithFailure)failure
{
    [self.baseTemplate setResponseClass:[VASMedia class]];
    [self.baseTemplate setMethod:kUserRecentMediaAPIUrl];
    
    [self.requestManager sendGETWithSuccess:^(id responseObject) {
        
        if (responseObject) {
            
            if (success)
                success(responseObject);
        }
    } failure:^(NSError *error) {
        
        if (error) {
            if (failure)
                failure(error);
        }
    }];
}

@end
