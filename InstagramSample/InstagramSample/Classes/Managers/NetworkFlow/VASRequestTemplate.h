//
//  VASRequestTemplate.h
//  InstagramSample
//
//  Created by Igor Vasilenko on 09/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol VASRequestTemplate <NSObject>

@property (nonatomic, readonly) NSURL *baseUrl;

@optional

@property (nonatomic, readonly) NSString *method;
@property (nonatomic, readonly) NSString *path;
@property (nonatomic, readonly) NSDictionary *parameters;
@property (nonatomic, readonly) NSDictionary *headers;

@end
