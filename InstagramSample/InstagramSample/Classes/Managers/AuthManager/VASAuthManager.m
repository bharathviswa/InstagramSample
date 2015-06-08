//
//  VASAuthManager.m
//  InstagramSample
//
//  Created by Igor Vasilenko on 08/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "VASAuthManager.h"

#import "SSKeychain.h"
#import "AFNetworking.h"

@interface VASAuthManager()

@property (nonatomic, strong) SSKeychain *keychainManager;

@end

@implementation VASAuthManager

- (void)authorizeUserWithSuccess:(AuthCompletionBlockWithSuccess)success
                         failure:(AuthCompletionBlockWithFailure)failure
{
    
}

- (void)p_storeTokenToKeychain:(NSString *)token
{
    
}

@end
