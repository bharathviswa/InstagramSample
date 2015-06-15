//
//  VASAuthenticationConfigurator.h
//  InstagramSample
//
//  Created by Igor Vasilenko on 15/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VASAuthenticationConfigurator : NSObject

#pragma mark - Configuration properties

@property (nonatomic, strong) NSString *clientID;
@property (nonatomic, strong) NSString *clientSecret;
@property (nonatomic, strong) NSString *grantType;

@property (nonatomic, strong) NSDictionary *requestTokenBaseParameters;
@property (nonatomic, strong) NSDictionary *authenticateBaseParameters;

@property (nonatomic, strong) NSString *authenticateURL;
@property (nonatomic, strong) NSString *requestTokenURL;
@property (nonatomic, strong) NSString *redirectURL;

#pragma mark - Initialize

+ (instancetype)defaultConfigurator;

- (instancetype)initWithClientID:(NSString *)clientID
                    clientSecret:(NSString *)clientSecret
                     redirectURL:(NSString *)redirectURL;

@end
