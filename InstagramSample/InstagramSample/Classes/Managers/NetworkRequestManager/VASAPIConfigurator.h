//
//  VASAPIConfigurator.h
//  InstagramSample
//
//  Created by Igor Vasilenko on 11/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VASAPIConfigurator : NSObject

@property (nonatomic, strong) NSURL *baseURL;

@property (nonatomic, strong) NSString *clientID;
@property (nonatomic, strong) NSString *clientSecret;

@end
