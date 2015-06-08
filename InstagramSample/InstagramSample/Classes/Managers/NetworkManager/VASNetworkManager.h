//
//  VASNetworkManager.h
//  InstagramSample
//
//  Created by Igor Vasilenko on 08/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NetworkManager [VASNetworkManager sharedInstance]

typedef void(^CompletionBlockWithSuccess)(NSArray *data);
typedef void(^CompletionBlockWithFailure)(NSError *error);

@interface VASNetworkManager : NSObject

+ (instancetype)sharedInstance;

- (void)requestUserInfoFromServerWithSuccess:(CompletionBlockWithSuccess)success
                                     failure:(CompletionBlockWithFailure)failure;
- (void)requestRecentUserMediaListWithSuccess:(CompletionBlockWithSuccess)success
                                      failure:(CompletionBlockWithFailure)failure;

@end
