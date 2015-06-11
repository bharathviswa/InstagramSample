//
//  VASSessionManager.h
//  InstagramSample
//
//  Created by Igor Vasilenko on 11/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "AFURLSessionManager.h"

typedef void(^CompletionHandler)(NSURLResponse *response, id responseObject, NSError *error);

@class VASAPIConfigurator;

@interface VASSessionManager : AFURLSessionManager

#pragma mark - Initialize

- (instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration
                        baseAPICongiguration:(id)baseAPIConfiguration;

#pragma mark - Helper methods

- (void)setResultClassForResponse:(Class)resultClass;

#pragma mark - GET data task

- (NSURLSessionDataTask *)dataTaskWithGETMethod:(NSString *)method
                                     parameters:(id)parameters
                              completionHandler:(CompletionHandler)completionHadler;

@end
