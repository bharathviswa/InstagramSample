//
//  VASSendableRequest.m
//  InstagramSample
//
//  Created by Igor Vasilenko on 09/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "VASNetworkRequestManager.h"

#import "AFNetworking.h"
#import "VASJSONResponseSerializer.h"
#import "VASSessionManager.h"

@interface VASNetworkRequestManager()

@property (nonatomic, strong) NSURL *baseURL;
@property (nonatomic, strong) VASSessionManager *sessionManager;

@end

@implementation VASNetworkRequestManager

#pragma mark - Initialize

- (instancetype)initWithBaseURL:(NSURL *)baseURL
          baseRequestParameters:(NSDictionary *)parameters
{
    if (self = [super init]) {
        _baseURL = baseURL;
        
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        _sessionManager = [[VASSessionManager alloc] initWithSessionConfiguration:sessionConfig baseAPICongiguration:@{}];
    }
    return self;
}

#pragma mark - Request's

- (NSURLSessionDataTask *)sendGetRequestWithMethod:(NSString *)method
                                        parameters:(NSDictionary *)parameters
                                       resultClass:(Class)resultClass
                                           success:(NetworkRequestCompletionBlockWithSuccess)success
                                           failure:(NetworkRequestCompletionBlockWithFailure)failure
{
    [self.sessionManager setResultClassForResponse:resultClass];
    
    NSURLSessionDataTask *dataTask = [self.sessionManager dataTaskWithGETMethod:method
                                                                     parameters:parameters
                                                              completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
                                                                  if (responseObject) {
                                                                      if (success)
                                                                          success(responseObject);
                                                                  }
                                                                  if (error) {
                                                                      if (failure)
                                                                          failure(error);
                                                                  }
                                                              }];
    [dataTask resume];
    
    return dataTask;
}

@end
