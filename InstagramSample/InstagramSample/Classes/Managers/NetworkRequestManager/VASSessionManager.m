//
//  VASURLSessionManager.m
//  InstagramSample
//
//  Created by Igor Vasilenko on 14/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "VASSessionManager.h"

#import "VASSessionResponseSerializer.h"

@interface VASSessionManager()

@property (nonatomic, strong) NSURL *baseURL;
@property (nonatomic, strong) NSDictionary *baseParameters;

@end

@implementation VASSessionManager

- (instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration
                                     baseURL:(NSURL *)baseURL
                              baseParameters:(id)parameters
{
    if (self == [super initWithSessionConfiguration:configuration])
    {
        _baseURL = baseURL;
        _baseParameters = parameters;
        _sessionResponseSerializer = [VASSessionResponseSerializer serializer];
    }
    return self;
}

#pragma mark - Requests data tasks

- (NSURLSessionDataTask *)method:(VASHTTPMethod)method
                       URLString:(NSString *)URLString
                      parameters:(id)parameters
                         success:(SessionManagerCompletionBlockWithSuccess)success
                         failure:(SessionManagerCompletionBlockWithFailure)failure
{
    return [self dataTaskWithMethod:method
                          URLString:URLString
                         parameters:parameters
                            success:success
                            failure:failure];
}

- (NSURLSessionDataTask *)method:(VASHTTPMethod)method
                       URLString:(NSString *)URLString
                      parameters:(id)parameters
                     resultClass:(Class)resultClass
                          forKey:(NSString *)key
                         success:(SessionManagerCompletionBlockWithSuccess)success
                         failure:(SessionManagerCompletionBlockWithFailure)failure
{
    __weak __typeof(self)weakSelf = self;
    
    return [self method:method
              URLString:URLString
             parameters:parameters
                success:^(NSURLSessionDataTask *task, id responseObject) {
                    
                    [weakSelf.sessionResponseSerializer parseJSON:responseObject
                                                          forKey:key
                                                     resultClass:resultClass
                                                            task:task
                                                         success:success
                                                         failure:failure];
                } failure:failure];
}

#pragma mark - HTTP Methods Data Tasks

- (NSURLSessionDataTask *)dataTaskWithMethod:(VASHTTPMethod)method
                                   URLString:(NSString *)URLString
                                  parameters:(id)parameters
                                     success:(SessionManagerCompletionBlockWithSuccess)success
                                     failure:(SessionManagerCompletionBlockWithFailure)failure
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:self.baseParameters];
    [params addEntriesFromDictionary:parameters];
    
    NSString *urlString = [[NSURL URLWithString:URLString? : [NSString string] relativeToURL:self.baseURL] absoluteString];
    NSURLRequest *urlRequest;
    
    switch (method) {
        case VASHTTPMethodGET:
            urlRequest = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET"
                                                                       URLString:urlString
                                                                      parameters:params
                                                                           error:NULL];
            break;
        case VASHTTPMethodPOST:
            urlRequest = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST"
                                                                       URLString:urlString
                                                                      parameters:params
                                                                           error:NULL];
            break;
        case VASHTTPMethodPUT:
            urlRequest = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"PUT"
                                                                       URLString:urlString
                                                                      parameters:params
                                                                           error:NULL];
            break;
        case VASHTTPMethodPATCH:
            urlRequest = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"PATCH"
                                                                       URLString:urlString
                                                                      parameters:params
                                                                           error:NULL];
            break;
        case VASHTTPMethodDELETE:
            urlRequest = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"DELETE"
                                                                       URLString:urlString
                                                                      parameters:params
                                                                           error:NULL];
            break;
            
            default:
            urlRequest = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET"
                                                                       URLString:urlString
                                                                      parameters:params
                                                                           error:NULL];
    }
    
    NSURLSessionDataTask *dataTask = [self dataTaskWithRequest:urlRequest
                                             completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
                                                 if (error)
                                                 {
                                                     failure(dataTask, error);
                                                 }
                                                 else
                                                 {
                                                     success(dataTask, responseObject);
                                                 }
                                             }];
    return dataTask;
}

@end
