//
//  VASOperationManager.h
//  InstagramSample
//
//  Created by Igor Vasilenko on 12/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

typedef void(^OperationManagerCompletionBlockWithSuccess)(AFHTTPRequestOperation *operation, id responseObject);
typedef void(^OperationManagerCompletionBlockWithFailure)(AFHTTPRequestOperation *operation, NSError *error);

@interface VASOperationManager : AFHTTPRequestOperationManager

- (instancetype)initWithBaseURL:(NSURL *)url
                configurationAPI:(id)configuration;

- (AFHTTPRequestOperation *)operationWithGET:(NSString *)method
                                  parameters:(id)parameters
                                 resultClass:(Class)resultClass
                                     success:(OperationManagerCompletionBlockWithSuccess)success
                                     failure:(OperationManagerCompletionBlockWithFailure)failure;

@end
