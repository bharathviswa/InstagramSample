//
//  VASAPIConfigurator.m
//  InstagramSample
//
//  Created by Igor Vasilenko on 15/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "VASAuthenticationConfigurator.h"

@implementation VASAuthenticationConfigurator

#pragma mark - Initialize

+ (instancetype)defaultConfigurator
{
    return [[self alloc] init];
}

- (instancetype)initWithClientID:(NSString *)clientID
                    clientSecret:(NSString *)clientSecret
                     redirectURL:(NSString *)redirectURL
{
    if (self = [super init]) {
        _clientID = clientID;
        _clientSecret = clientSecret;
        _redirectURL = redirectURL;
    }
    return self;
}

#pragma mark - Configuration properties

- (NSString *)clientID
{
    if (_clientID) {
        return _clientID;
    }
    // default
    return @"40240e26887c4478b22426c15bb55c59";
}

- (NSString *)clientSecret
{
    if (_clientSecret) {
        return _clientSecret;
    }
    // default
    return @"292c6144a7a04b378675fa58e1daf4c7";
}

- (NSString *)grantType
{
    if (_grantType) {
        return _grantType;
    }
    // default
    return @"authorization_code";
}

- (NSDictionary *)requestTokenBaseParameters
{
    return @{
             @"client_id" : self.clientID,
             @"client_secret" : self.clientSecret,
             @"grant_type" : self.grantType,
             @"redirect_uri" : self.redirectURL
             };
}

- (NSDictionary *)authenticateBaseParameters
{
    return @{
             @"client_id" : self.clientID,
             @"redirect_uri" : self.redirectURL,
             @"response_type" : @"code"
             };
}

- (NSString *)authenticateURL
{
    if (_authenticateURL) {
        return _authenticateURL;
    }
    // default
    return @"https://instagram.com/oauth/authorize/";
}

- (NSString *)requestTokenURL
{
    if (_requestTokenURL) {
        return _requestTokenURL;
    }
    // default
    return @"https://api.instagram.com/oauth/access_token/";
}

- (NSString *)redirectURL
{
    if (_redirectURL) {
        return _redirectURL;
    }
    // default
    return @"http://spbvasilenko.github.com";
}

@end
