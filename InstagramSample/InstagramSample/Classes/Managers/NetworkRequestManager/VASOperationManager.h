//
//  VASOperationManager.h
//  InstagramSample
//
//  Created by Igor Vasilenko on 12/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

typedef NS_ENUM(NSUInteger, VASHTTPMethod) {
    VASHTTPMethodGET,
    VASHTTPMethodPOST,
    VASHTTPMethodPUT,
    VASHTTPMethodPATH,
    VASHTTPMethodDELETE
};

typedef void(^OperationManagerCompletionBlockWithSuccess)(AFHTTPRequestOperation *operation, id responseObject);
typedef void(^OperationManagerCompletionBlockWithFailure)(AFHTTPRequestOperation *operation, NSError *error);

@interface VASOperationManager : AFHTTPRequestOperationManager

#pragma mark - Initialize

- (instancetype)initWithBaseURL:(NSURL *)url
               configurationAPI:(id)configuration;

#pragma mark - Operations

- (AFHTTPRequestOperation *)method:(VASHTTPMethod)method
                         URLString:(NSString *)URLString
                        parameters:(id)parameters
                           success:(OperationManagerCompletionBlockWithSuccess)success
                           failure:(OperationManagerCompletionBlockWithFailure)failure;

- (AFHTTPRequestOperation *)method:(VASHTTPMethod)method
                         URLString:(NSString *)URLString
                        parameters:(id)parameters
                       resultClass:(Class)resultClass
                            forKey:(NSString *)key
                           success:(OperationManagerCompletionBlockWithSuccess)success
                           failure:(OperationManagerCompletionBlockWithFailure)failure;

@end
