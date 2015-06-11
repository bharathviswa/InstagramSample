//
//  VASNetworkManager.h
//  InstagramSample
//
//  Created by Igor Vasilenko on 08/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VASUser;

typedef void(^CompletionBlockWithSuccess)(id responseObject);
typedef void(^CompletionBlockWithFailure)(NSError *error);

@interface VASNetworkManager : NSObject

- (void)requestUserInfoWithSuccess:(CompletionBlockWithSuccess)success
                           failure:(CompletionBlockWithFailure)failure;
- (void)requestRecentUserMediaListWithSuccess:(CompletionBlockWithSuccess)success
                                      failure:(CompletionBlockWithFailure)failure;

@end
