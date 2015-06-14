//
//  VASJSONResponseSerializer.m
//  InstagramSample
//
//  Created by Igor Vasilenko on 10/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "VASOperationResponseSerializer.h"

@interface VASOperationResponseSerializer()

@property (nonatomic, strong) Class resultClass;
@property (nonatomic, strong) id resultResponseObject;
@property (nonatomic, strong) NSString *keyPath;

@end

@implementation VASOperationResponseSerializer

- (instancetype)initWithResultClass:(Class)resultClass forKey:(NSString *)key
{
    if (self = [super init]) {
        self.keyPath = key;
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
        if ([responseObject[self.keyPath] isKindOfClass:[NSArray class]])
        {
            self.resultResponseObject = [MTLJSONAdapter modelsOfClass:self.resultClass
                                                        fromJSONArray:responseObject[self.keyPath]
                                                                error:NULL];
        }
        else if ([responseObject[self.keyPath] isKindOfClass:[NSDictionary class]])
        {
            self.resultResponseObject = [MTLJSONAdapter modelOfClass:self.resultClass
                                                  fromJSONDictionary:responseObject[self.keyPath]
                                                               error:NULL];
        }
    }
    else
    {
        return responseObject;
    }
    
    return self.resultResponseObject;
}

@end
