//
//  VASOperationManager.m
//  InstagramSample
//
//  Created by Igor Vasilenko on 12/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "VASOperationManager.h"

#import "VASJSONResponseSerializer.h"

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

- (AFHTTPRequestOperation *)operationWithGET:(NSString *)method
                                  parameters:(id)parameters
                                 resultClass:(Class)resultClass
                                     success:(OperationManagerCompletionBlockWithSuccess)success
                                     failure:(OperationManagerCompletionBlockWithFailure)failure
{
    NSURLRequest *urlRequest = [self requestWithGET:method parameters:parameters];
    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:urlRequest                                                                      success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
    
    VASJSONResponseSerializer *responseSerializer = [[VASJSONResponseSerializer alloc] initWithResultClass:resultClass];
    operation.responseSerializer = responseSerializer;
    
    return operation;
}

#pragma mark - Request's

- (NSURLRequest *)requestWithGET:(NSString *)method parameters:(id)parameters
{
    [self.parameters addEntriesFromDictionary:parameters];
    NSString *urlString = [[NSURL URLWithString:method? : [NSString string] relativeToURL:self.baseURL] absoluteString];
    
    NSURLRequest *urlRequest = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET"
                                                                             URLString:urlString
                                                                            parameters:self.parameters
                                                                                 error:NULL];
    return urlRequest;
}

@end
