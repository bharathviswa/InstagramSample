//
//  VASSendableRequest.m
//  InstagramSample
//
//  Created by Igor Vasilenko on 09/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "VASNetworkRequestManager.h"

#import "AFNetworking.h"
#import "VASTemplateRequest.h"

@interface VASNetworkRequestManager()

@property (nonatomic, strong) id responseObject;

@end

@implementation VASNetworkRequestManager

- (instancetype)initWithRequestTemplate:(VASTemplateRequest *)templateRequest
{
    if (self = [super init]) {
        self.templateRequest = templateRequest;
    }
    return self;
}

- (void)sendGETWithSuccess:(NetworkRequestCompletionBlockWithSuccess)success
                   failure:(NetworkRequestCompletionBlockWithFailure)failure
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:self.templateRequest.parameters];
    params[@"client_id"] = kInstagramAPIClientID;
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:self.templateRequest.baseURL];
    [manager GET:self.templateRequest.method? : @"" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject)
        {
            if (self.templateRequest.responseClass)
            {
                NSError *error;
                
                if ([responseObject[@"data"] isKindOfClass:[NSArray class]]) {
                    _responseObject = [MTLJSONAdapter modelsOfClass:self.templateRequest.responseClass
                                                      fromJSONArray:responseObject[@"data"]
                                                              error:&error];
                }
                if ([responseObject[@"data"] isKindOfClass:[NSDictionary class]]) {
                    _responseObject = [MTLJSONAdapter modelOfClass:self.templateRequest.responseClass
                                                fromJSONDictionary:responseObject[@"data"]
                                                             error:&error];
                }
                
                if (success)
                    success(_responseObject);
            }
            else
            {
                if (success)
                    success(responseObject);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (error) {
            if (failure)
                failure(error);
        }
    }];
}

@end
