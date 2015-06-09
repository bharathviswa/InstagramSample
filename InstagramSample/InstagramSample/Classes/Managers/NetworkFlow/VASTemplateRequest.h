//
//  VASTemplateRequest.h
//  InstagramSample
//
//  Created by Igor Vasilenko on 09/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VASTemplateRequest : NSObject

@property (nonatomic, strong) NSURL *baseURL;

@property (nonatomic, strong) NSString *method;
@property (nonatomic, strong) NSDictionary *parameters;
@property (nonatomic, strong) Class responseClass;

- (instancetype)initWithBaseURL:(NSURL *)baseURL;

@end
