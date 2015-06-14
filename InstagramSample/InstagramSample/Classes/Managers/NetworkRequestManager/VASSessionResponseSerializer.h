//
//  VASSessionResponseSerializer.h
//  InstagramSample
//
//  Created by Igor Vasilenko on 14/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "AFURLResponseSerialization.h"

typedef void(^VASSessionResponseSerializerAnyBlock)(NSURLSessionDataTask *task, id object);
typedef void(^VASSessionResponseSerializerWithError)(NSURLSessionDataTask *task, NSError *error);

@interface VASSessionResponseSerializer : AFJSONResponseSerializer

@property (nonatomic, strong) dispatch_queue_t dispatch_queue;

- (void)parseJSON:(id)JSON
           forKey:(NSString *)key
      resultClass:(Class)resultClass
             task:(NSURLSessionDataTask *)dataTask
          success:(VASSessionResponseSerializerAnyBlock)success
          failure:(VASSessionResponseSerializerWithError)failure;

@end
