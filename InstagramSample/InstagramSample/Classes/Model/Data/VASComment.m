//
//  VASComment.m
//  InstagramSample
//
//  Created by Igor Vasilenko on 09/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "VASComment.h"

#import "VASUser.h"

@implementation VASComment

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"fromUser" : @"from",
             @"uid" : @"id",
             @"createdTime" : @"created_time",
             @"text" : @"text"
             };
}

+ (NSValueTransformer *)createdTimeJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *date, BOOL *success, NSError *__autoreleasing *error) {
        return [NSDate dateWithTimeIntervalSince1970:date.integerValue];
    }];
}

+ (NSValueTransformer *)fromUserJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSDictionary *dict, BOOL *success, NSError *__autoreleasing *error) {
        return [MTLJSONAdapter modelOfClass:[VASUser class] fromJSONDictionary:dict error:error];
    }];
}

@end
