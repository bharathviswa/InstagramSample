//
//  VASNetworkManager.m
//  InstagramSample
//
//  Created by Igor Vasilenko on 08/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "VASNetworkManager.h"

#import "AFNetworking.h"

@implementation VASNetworkManager

+ (instancetype)sharedInstance
{
    static VASNetworkManager *sharedInstance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)requestUserInfoFromServerWithSuccess:(CompletionBlockWithSuccess)success
                                     failure:(CompletionBlockWithFailure)failure
{
    
}

- (void)requestRecentUserMediaListWithSuccess:(CompletionBlockWithSuccess)success
                                      failure:(CompletionBlockWithFailure)failure
{
    
}

@end
