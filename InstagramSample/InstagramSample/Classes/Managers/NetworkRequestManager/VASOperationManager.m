//
//  VASOperationManager.m
//  InstagramSample
//
//  Created by Igor Vasilenko on 12/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "VASOperationManager.h"

#import "VASOperationResponseSerializer.h"

@interface VASOperationManager()

@property (nonatomic, strong) NSMutableDictionary *parameters;

@end

@implementation VASOperationManager

#pragma mark - Initialize

- (instancetype)initWithBaseURL:(NSURL *)url
               configurationAPI:(id)configuration
{
    if (self = [super initWithBaseURL:url]) {
        _parameters = [NSMutableDictionary dictionaryWithDictionary:configuration];
    }
    return self;
}

#pragma mark - Operations

- (AFHTTPRequestOperation *)method:(VASHTTPMethod)method
                         URLString:(NSString *)URLString
                        parameters:(id)parameters
                           success:(OperationManagerCompletionBlockWithSuccess)success
                           failure:(OperationManagerCompletionBlockWithFailure)failure
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
        case VASHTTPMethodPATH:
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
            break;
    }
}

- (AFHTTPRequestOperation *)method:(VASHTTPMethod)method
                         URLString:(NSString *)URLString
                        parameters:(id)parameters
                       resultClass:(Class)resultClass
                            forKey:(NSString *)key
                           success:(OperationManagerCompletionBlockWithSuccess)success
                           failure:(OperationManagerCompletionBlockWithFailure)failure
{
    AFHTTPRequestOperation *operation = [self method:method
                                           URLString:URLString
                                          parameters:parameters
                                             success:success
                                             failure:failure];
    
    VASOperationResponseSerializer *operationResponseSerializer = [[VASOperationResponseSerializer alloc] initWithResultClass:resultClass forKey:key];
    operation.responseSerializer = operationResponseSerializer;
    
    return operation;
}

#pragma mark - HTTP Operations
#pragma mark GET

- (AFHTTPRequestOperation *)GET:(NSString *)URLString
                     parameters:(id)parameters
                        success:(OperationManagerCompletionBlockWithSuccess)success
                        failure:(OperationManagerCompletionBlockWithFailure)failure
{
    NSURLRequest *urlRequest = [self requestWithGET:URLString parameters:parameters];
    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:urlRequest
                                                                      success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                          if (responseObject) {
                                                                              if (success)
                                                                                  success(operation, responseObject);
                                                                          }
                                                                      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                          if (error) {
                                                                              if (failure)
                                                                                  failure(operation, error);
                                                                          }
                                                                      }];
    return operation;
}

#pragma mark - Request's
#pragma mark GET

- (NSURLRequest *)requestWithGET:(NSString *)URLString parameters:(id)parameters
{
    [self.parameters addEntriesFromDictionary:parameters];
    NSString *urlString = [[NSURL URLWithString:URLString? : [NSString string] relativeToURL:self.baseURL] absoluteString];

    NSURLRequest *urlRequest = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET"
                                                                             URLString:urlString
                                                                            parameters:self.parameters
                                                                                 error:NULL];
    return urlRequest;
}

@end