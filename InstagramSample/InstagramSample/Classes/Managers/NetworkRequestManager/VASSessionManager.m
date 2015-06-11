//
//  VASSessionManager.m
//  InstagramSample
//
//  Created by Igor Vasilenko on 11/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "VASSessionManager.h"

#import "VASJSONResponseSerializer.h"
#import "VASAPIConfigurator.h"

@interface VASSessionManager()

@property (nonatomic, strong) NSURL *baseURL;
@property (nonatomic, strong) NSMutableArray *responseSerializers;
@property (nonatomic, strong) NSMutableDictionary *parameters;

@end

@implementation VASSessionManager

- (instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration
                        baseAPICongiguration:(id)baseAPIConfiguration
{
    if (self = [super initWithSessionConfiguration:configuration]) {
        
        _responseSerializers = [@[] mutableCopy];
        _baseURL = [NSURL URLWithString:kInstagramBaseAPIUrl];
        _parameters = [@{
                        @"client_id" : kInstagramAPIClientID
                        } mutableCopy];
    }
    return self;
}

- (void)configureManagerWithAPIConfigurator:(VASAPIConfigurator *)apiConfigurator
{
//    if (apiConfigurator) {
//        _parameters = [@{@"client_id" : apiConfigurator.clientID} mutableCopy];
//        _baseURL = apiConfigurator.baseURL;
//    }
}

- (void)setResultClassForResponse:(Class)resultClass
{
    VASJSONResponseSerializer *responseSerializer = [[VASJSONResponseSerializer alloc] initWithResultClass:resultClass];
    [self.responseSerializers addObject:responseSerializer];
    
    AFCompoundResponseSerializer *compoundResponseSerializer = [AFCompoundResponseSerializer compoundSerializerWithResponseSerializers:[self.responseSerializers copy]];
    self.responseSerializer = compoundResponseSerializer;
}

- (NSURLSessionDataTask *)dataTaskWithGETMethod:(NSString *)method
                                     parameters:(id)parameters
                              completionHandler:(CompletionHandler)completionHadler
{
    [self.parameters addEntriesFromDictionary:parameters];
    NSURLRequest *urlRequest = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET"
                                                                             URLString:[[NSURL URLWithString:method? : @"" relativeToURL:self.baseURL] absoluteString]
                                                                            parameters:self.parameters
                                                                                 error:NULL];
    
    return [self dataTaskWithRequest:urlRequest
                   completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
                       completionHadler(response, responseObject, error);
                   }];
}

@end
