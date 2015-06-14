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
@property (nonatomic, strong) NSMutableDictionary *parameters;

@end

@implementation VASSessionManager

- (instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration
                                     baseURL:(NSURL *)baseURL
                              baseParameters:(id)parameters
{
    if (self == [super initWithSessionConfiguration:configuration]) {
        _baseURL = baseURL;
        _parameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
        _sessionResponseSerializer = [VASSessionResponseSerializer serializer];
        self.responseSerializer = _sessionResponseSerializer;
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
    switch (method) {
        case VASHTTPMethodGET:
            return [self GET:URLString
                  parameters:parameters
                     success:success
                     failure:failure];
            break;
        case VASHTTPMethodPOST:
            return nil;
            break;
        case VASHTTPMethodPUT:
            return nil;
            break;
        case VASHTTPMethodPATCH:
            return nil;
            break;
        case VASHTTPMethodDELETE:
            return nil;
            break;

        default:
            return [self GET:URLString
                  parameters:parameters
                     success:success
                     failure:failure];
    }
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
#pragma mark GET

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(SessionManagerCompletionBlockWithSuccess)success
                      failure:(SessionManagerCompletionBlockWithFailure)failure
{
    [self.parameters addEntriesFromDictionary:parameters];
    NSString *urlString = [[NSURL URLWithString:URLString? : [NSString string] relativeToURL:self.baseURL] absoluteString];
    
    NSURLRequest *urlRequest = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET"
                                                                             URLString:urlString
                                                                            parameters:self.parameters
                                                                                 error:NULL];
    __block NSURLSessionDataTask *dataTask = nil;
    
    dataTask = [self dataTaskWithRequest:urlRequest
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
