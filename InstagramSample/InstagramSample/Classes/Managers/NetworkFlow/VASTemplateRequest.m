//
//  VASTemplateRequest.m
//  InstagramSample
//
//  Created by Igor Vasilenko on 09/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "VASTemplateRequest.h"

@interface VASTemplateRequest()

@property (nonatomic, strong) NSString *clientID;

@end

@implementation VASTemplateRequest

- (instancetype)initWithBaseURL:(NSURL *)baseURL
{
    if (self = [super init]) {
        _baseURL = baseURL;
    }
    return self;
}

@end
