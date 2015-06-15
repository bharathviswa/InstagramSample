//
//  VASSessionResponseSerializer.m
//  InstagramSample
//
//  Created by Igor Vasilenko on 14/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "VASSessionResponseSerializer.h"

#import <Mantle/MTLJSONAdapter.h>

@implementation VASSessionResponseSerializer

+ (instancetype)serializer
{
    return [[self alloc] init];
}

- (instancetype)init
{
    if (self = [super init]) {
        self.dispatch_queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    }
    return self;
}

- (void)parseJSON:(id)JSON
           forKey:(NSString *)key
      resultClass:(Class)resultClass
             task:(NSURLSessionDataTask *)dataTask
          success:(VASSessionResponseSerializerAnyBlock)success
          failure:(VASSessionResponseSerializerWithError)failure
{
    [self parseJSON:JSON resultClass:resultClass forKey:key completion:^(id model, NSError *error) {
        if (model) {
            [self sendObject:model withTask:dataTask inBlock:success];
        } else {
            [self sendObject:error withTask:dataTask inBlock:failure];
        }
    }];
}

- (void)parseJSON:(id)JSON
      resultClass:(Class)resultClass
           forKey:(NSString *)key
       completion:(void(^)(id model, NSError *error))completion
{
    dispatch_async(self.dispatch_queue, ^{
        NSError *error;
        id model = [self parseJSON:JSON forKey:key resultClass:resultClass error:error];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(model, error);
        });
    });
}

- (id)parseJSON:(id)JSON
         forKey:(NSString *)key
    resultClass:(Class)resultClass
          error:(NSError *)error
{
    if ([JSON[key] isKindOfClass:[NSArray class]]) {
        return [MTLJSONAdapter modelsOfClass:resultClass fromJSONArray:JSON[key] error:&error];
    }
    return [MTLJSONAdapter modelOfClass:resultClass fromJSONDictionary:JSON[key] error:&error];
}

#pragma mark - Perform block

- (void)sendObject:(id)object withTask:(NSURLSessionDataTask *)task inBlock:(VASSessionResponseSerializerAnyBlock)block
{
    if (block) {
        block(task, object);
    }
}

@end
