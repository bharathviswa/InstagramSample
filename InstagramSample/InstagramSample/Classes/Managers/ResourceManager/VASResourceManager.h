//
//  VASNetworkManager.h
//  InstagramSample
//
//  Created by Igor Vasilenko on 08/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompletionBlockWithSuccess)(id responseObject);
typedef void(^CompletionBlockWithFailure)(NSError *error);

@interface VASResourceManager : NSObject

- (NSURLSessionDataTask *)requestUserInfoWithID:(NSString *)userID
                                        success:(CompletionBlockWithSuccess)success
                                        failure:(CompletionBlockWithFailure)failure;
- (NSURLSessionDataTask *)requestRecentUserMediaListWithID:(NSString *)userID
                                                   success:(CompletionBlockWithSuccess)success
                                                   failure:(CompletionBlockWithFailure)failure;

@end
