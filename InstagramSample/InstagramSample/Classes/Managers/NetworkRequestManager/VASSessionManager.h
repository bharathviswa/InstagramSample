//
//  VASURLSessionManager.h
//  InstagramSample
//
//  Created by Igor Vasilenko on 14/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "AFURLSessionManager.h"

@class VASSessionResponseSerializer;

typedef void(^VASURLSessionManagerCompletionBlockWithSuccess)(NSURLSessionDataTask *task, id responseObject);
typedef void(^VASURLSessionManagerCompletionBlockWithFailure)(NSURLSessionDataTask *task, NSError *error);

typedef NS_ENUM(NSUInteger, VASRequestMethod) {
    VASRequestMethodGET,
    VASRequestMethodPOST,
    VASRequestMethodPUT,
    VASRequestMethodPATCH,
    VASRequestMethodDELETE
};

@interface VASSessionManager : AFURLSessionManager

@property (nonatomic, strong, readonly) VASSessionResponseSerializer *sessionResponseSerializer;

- (instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration
                                     baseURL:(NSURL *)baseURL
                              baseParameters:(id)parameters;

- (NSURLSessionDataTask *)method:(VASRequestMethod)method
                       URLString:(NSString *)URLString
                      parameters:(id)parameters
                         success:(VASURLSessionManagerCompletionBlockWithSuccess)success
                         failure:(VASURLSessionManagerCompletionBlockWithFailure)failure;

- (NSURLSessionDataTask *)method:(VASRequestMethod)method
                       URLString:(NSString *)URLString
                      parameters:(id)parameters
                     resultClass:(Class)resultClass
                          forKey:(NSString *)key
                         success:(VASURLSessionManagerCompletionBlockWithSuccess)success
                         failure:(VASURLSessionManagerCompletionBlockWithFailure)failure;

@end
