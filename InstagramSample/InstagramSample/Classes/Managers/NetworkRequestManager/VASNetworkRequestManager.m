//
//  VASSendableRequest.m
//  InstagramSample
//
//  Created by Igor Vasilenko on 09/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "VASNetworkRequestManager.h"

#import "AFNetworking.h"
#import "VASOperationManager.h"
#import "VASSessionManager.h"

@interface VASNetworkRequestManager()

@property (nonatomic, strong) VASOperationManager *operationManager;
@property (nonatomic, strong) VASSessionManager *sessionManager;

@end

@implementation VASNetworkRequestManager

#pragma mark - Initialize

- (instancetype)initWithBaseURL:(NSURL *)baseURL
          baseRequestParameters:(NSDictionary *)parameters
{
    if (self = [super init]) {
        _operationManager = [[VASOperationManager alloc] initWithBaseURL:baseURL
                                                        configurationAPI:parameters];
        
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        _sessionManager = [[VASSessionManager alloc] initWithSessionConfiguration:sessionConfig
                                                                          baseURL:baseURL
                                                                   baseParameters:parameters];
    }
    return self;
}

#pragma mark - Request's

- (NSURLSessionDataTask *)resumeTaskWithGetRequestWithMethod:(NSString *)method
                                                  parameters:(id)parameters
                                                 resultClass:(Class)resultClass
                                                     success:(NetworkRequestCompletionBlockWithSuccess)success
                                                     failure:(NetworkRequestCompletionBlockWithFailure)failure
{
    NSURLSessionDataTask *task = [self.sessionManager method:VASRequestMethodGET
                                                   URLString:method
                                                  parameters:parameters
                                                 resultClass:resultClass
                                                      forKey:@"data"
                                                     success:^(NSURLSessionDataTask *task, id responseObject) {
                                                         if (responseObject) {
                                                             success(responseObject);
                                                         }
                                                     } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                         if (error) {
                                                             failure(error);
                                                         }
                                                     }];
    [task resume];
    
    return task;
}

- (AFHTTPRequestOperation *)sendGetRequestWithMethod:(NSString *)method
                                          parameters:(id)parameters
                                         resultClass:(Class)resultClass
                                             success:(NetworkRequestCompletionBlockWithSuccess)success
                                             failure:(NetworkRequestCompletionBlockWithFailure)failure
{
    AFHTTPRequestOperation *operation = [self.operationManager operationWithGET:method
                                                                     parameters:parameters
                                                                    resultClass:resultClass
                                                                        success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                            if (responseObject) {
                                                                                if (success)
                                                                                    success(responseObject);
                                                                            }
                                                                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                            if (error) {
                                                                                if (failure)
                                                                                    failure(error);
                                                                            }
                                                                        }];
    [operation start];
    
    return operation;
}

@end
