//
//  VASJSONResponseSerializer.m
//  InstagramSample
//
//  Created by Igor Vasilenko on 10/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "VASJSONResponseSerializer.h"

@interface VASJSONResponseSerializer()

@property (nonatomic, strong) Class resultClass;
@property (nonatomic, strong) id resultResponseObject;

@end

@implementation VASJSONResponseSerializer

- (instancetype)initWithResultClass:(Class)resultClass
{
    if (self = [super init])
    {
        self.resultClass = resultClass;
        self.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    }
    return self;
}

- (id)responseObjectForResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError *__autoreleasing *)error
{
    id responseObject = [super responseObjectForResponse:response data:data error:error];
    
    if (self.resultClass)
    {
        if ([responseObject[@"data"] isKindOfClass:[NSArray class]])
        {
            self.resultResponseObject = [MTLJSONAdapter modelsOfClass:self.resultClass
                                                        fromJSONArray:responseObject[@"data"]
                                                                error:NULL];
        }
        else if ([responseObject[@"data"] isKindOfClass:[NSDictionary class]])
        {
            self.resultResponseObject = [MTLJSONAdapter modelOfClass:self.resultClass
                                                  fromJSONDictionary:responseObject[@"data"]
                                                               error:NULL];
        }
    }
    else
    {
        return responseObject;
    }
    
    return self.resultResponseObject;
}

- (void)setResultClass:(Class)resultClass
{
    if (resultClass) {
        _resultClass = resultClass;
    }
}

@end
