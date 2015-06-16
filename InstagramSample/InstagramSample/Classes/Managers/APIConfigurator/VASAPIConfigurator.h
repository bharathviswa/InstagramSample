//
//  VASAPIConfigurator.h
//  InstagramSample
//
//  Created by Igor Vasilenko on 16/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, VASAPIConfiguratorType) {
    VASAPIConfiguratorBase,
    VASAPIConfiguratorAuth
};

@interface VASAPIConfigurator : NSObject

#pragma mark - Base

@property (nonatomic, strong) NSURL *baseAPIURL;
@property (nonatomic, strong) NSDictionary *baseParameters;

- (instancetype)initWithBaseAPIURL:(NSURL *)baseAPIURL;

#pragma mark - Authentication

@property (nonatomic, strong) NSString *clientID;
@property (nonatomic, strong) NSString *clientSecret;
@property (nonatomic, strong) NSString *grantType;

@property (nonatomic, strong) NSDictionary *authenticateBaseParameters;

@property (nonatomic, strong) NSString *authenticateURL;
@property (nonatomic, strong) NSString *requestTokenURL;
@property (nonatomic, strong) NSString *redirectURL;

#pragma mark - Initialize

- (instancetype)initWithBaseURL:(NSURL *)baseURL
                       clientID:(NSString *)clientID
                   clientSecret:(NSString *)clientSecret
                    redirectURL:(NSString *)redirectURL;

+ (instancetype)baseConfigurator;
+ (instancetype)authenticationConfigurator;

@end
