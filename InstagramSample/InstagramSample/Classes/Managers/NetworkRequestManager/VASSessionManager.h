//
//  VASURLSessionManager.h
//  InstagramSample
//
//  Created by Igor Vasilenko on 14/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "AFURLSessionManager.h"

@class VASSessionResponseSerializer;
@class VASAPIConfigurator;

typedef void(^SessionManagerCompletionBlockWithSuccess)(NSURLSessionDataTask *task, id responseObject);
typedef void(^SessionManagerCompletionBlockWithFailure)(NSURLSessionDataTask *task, NSError *error);

typedef NS_ENUM(NSUInteger, VASHTTPMethod) {
    VASHTTPMethodGET,
    VASHTTPMethodPOST,
    VASHTTPMethodPUT,
    VASHTTPMethodPATCH,
    VASHTTPMethodDELETE
};

@interface VASSessionManager : AFURLSessionManager

@property (nonatomic, strong, readonly) VASSessionResponseSerializer *sessionResponseSerializer;

- (instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration
                            configurationAPI:(VASAPIConfigurator *)configurationAPI;

- (NSURLSessionDataTask *)method:(VASHTTPMethod)method
                       URLString:(NSString *)URLString
                      parameters:(id)parameters
                         success:(SessionManagerCompletionBlockWithSuccess)success
                         failure:(SessionManagerCompletionBlockWithFailure)failure;

- (NSURLSessionDataTask *)method:(VASHTTPMethod)method
                       URLString:(NSString *)URLString
                      parameters:(id)parameters
                     resultClass:(Class)resultClass
                          forKey:(NSString *)key
                         success:(SessionManagerCompletionBlockWithSuccess)success
                         failure:(SessionManagerCompletionBlockWithFailure)failure;
@end
