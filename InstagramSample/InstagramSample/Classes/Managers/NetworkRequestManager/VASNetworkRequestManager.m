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

@interface VASNetworkRequestManager()

@property (nonatomic, strong) NSURL *baseURL;
@property (nonatomic, strong) NSMutableDictionary *baseRequestParameters;
@property (nonatomic, strong) NSURLSessionConfiguration *sessionConfig;

@end

@implementation VASNetworkRequestManager

#pragma mark - Initialize

- (instancetype)initWithBaseURL:(NSURL *)baseURL
          baseRequestParameters:(NSDictionary *)parameters
{
    if (self = [super init]) {
        _baseURL = baseURL;
        _baseRequestParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
        
        _sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    }
    return self;
}

#pragma mark - Request's

- (void)sendGetRequestWithMethod:(NSString *)method
                      parameters:(NSDictionary *)parameters
                   resultClass:(Class)resultClass
                         success:(NetworkRequestCompletionBlockWithSuccess)success
                         failure:(NetworkRequestCompletionBlockWithFailure)failure
{
    AFURLSessionManager *sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:self.sessionConfig];
    VASJSONResponseSerializer *responseSerializer = [[VASJSONResponseSerializer alloc] initWithResultClass:resultClass];
    sessionManager.responseSerializer = responseSerializer;
    
    [self.baseRequestParameters addEntriesFromDictionary:parameters];
    NSURLRequest *urlRequest = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET"
                                                                             URLString:[[NSURL URLWithString:method? : @"" relativeToURL:self.baseURL] absoluteString]
                                                                            parameters:self.baseRequestParameters
                                                                                 error:NULL];
    
    NSURLSessionDataTask *dataTask = [sessionManager dataTaskWithRequest:urlRequest
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
}

@end
