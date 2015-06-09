//
//  VASMedia.m
//  InstagramSample
//
//  Created by Igor Vasilenko on 09/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "VASMedia.h"

#import "VASUser.h"
#import "VASComment.h"

@implementation VASMedia

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"uid" : @"id",
             @"createdTime" : @"created_time",
             @"standardImageLink" : @"images.standard_resolution.url",
             @"thumbailImageLink" : @"images.thumbnail.url",
             @"likes" : @"likes",
             @"comments" : @"comments",
             @"tags" : @"tags"
             };
}

+ (NSValueTransformer *)createdTimeJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *date, BOOL *success, NSError *__autoreleasing *error) {
        return [NSDate dateWithTimeIntervalSince1970:date.integerValue];
    }];
}

+ (NSValueTransformer *)likesJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSDictionary *dict, BOOL *success, NSError *__autoreleasing *error) {
        return [MTLJSONAdapter modelsOfClass:[VASUser class] fromJSONArray:dict[@"data"] error:error];
    }];
}

+ (NSValueTransformer *)commentsJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSDictionary *dict, BOOL *success, NSError *__autoreleasing *error) {
        return [MTLJSONAdapter modelsOfClass:[VASComment class] fromJSONArray:dict[@"data"] error:error];
    }];
}

@end
