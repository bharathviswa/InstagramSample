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

#pragma mark - Users

- (NSURLSessionDataTask *)requestUserInfoWithID:(NSString *)userID
                                        success:(CompletionBlockWithSuccess)success
                                        failure:(CompletionBlockWithFailure)failure;

- (NSURLSessionDataTask *)requestRecentUserMediaListWithID:(NSString *)userID
                                                   success:(CompletionBlockWithSuccess)success
                                                   failure:(CompletionBlockWithFailure)failure;

- (NSURLSessionDataTask *)requestSelfMediaFeedListWithSuccess:(CompletionBlockWithSuccess)success
                                                      failure:(CompletionBlockWithFailure)failure;

#pragma mark - Media

- (NSURLSessionDataTask *)requestMediaInfoWithID:(NSString *)mediaID
                                         success:(CompletionBlockWithSuccess)success
                                         failure:(CompletionBlockWithFailure)failure;

- (NSURLSessionDataTask *)requestPopularMediaListWithSuccess:(CompletionBlockWithSuccess)success
                                                     failure:(CompletionBlockWithFailure)failure;

@end
