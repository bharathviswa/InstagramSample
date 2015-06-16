//
//  VASNetworkManager.h
//  InstagramSample
//
//  Created by Igor Vasilenko on 08/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ResourceManagerCompletionBlockWithSuccess)(id responseObject);
typedef void(^ResourceManagerCompletionBlockWithFailure)(NSError *error);

@interface VASResourceManager : NSObject

#pragma mark - Users

- (NSURLSessionDataTask *)userInfoWithID:(NSString *)userID
                                 success:(ResourceManagerCompletionBlockWithSuccess)success
                                 failure:(ResourceManagerCompletionBlockWithFailure)failure;

- (NSURLSessionDataTask *)recentUserMediaListWithID:(NSString *)userID
                                            success:(ResourceManagerCompletionBlockWithSuccess)success
                                            failure:(ResourceManagerCompletionBlockWithFailure)failure;

- (NSURLSessionDataTask *)selfMediaFeedListWithSuccess:(ResourceManagerCompletionBlockWithSuccess)success
                                               failure:(ResourceManagerCompletionBlockWithFailure)failure;

- (NSURLSessionDataTask *)userFollowsListWithID:(NSString *)userID
                                        success:(ResourceManagerCompletionBlockWithSuccess)success
                                        failure:(ResourceManagerCompletionBlockWithFailure)failure;

- (NSURLSessionDataTask *)userFollowedByListWithID:(NSString *)userID
                                           success:(ResourceManagerCompletionBlockWithSuccess)success
                                           failure:(ResourceManagerCompletionBlockWithFailure)failure;

#pragma mark - Media

- (NSURLSessionDataTask *)mediaInfoWithID:(NSString *)mediaID
                                  success:(ResourceManagerCompletionBlockWithSuccess)success
                                  failure:(ResourceManagerCompletionBlockWithFailure)failure;

- (NSURLSessionDataTask *)popularMediaListWithSuccess:(ResourceManagerCompletionBlockWithSuccess)success
                                              failure:(ResourceManagerCompletionBlockWithFailure)failure;

@end
