//
//  VASAPIConfigurator.m
//  InstagramSample
//
//  Created by Igor Vasilenko on 16/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "VASAPIConfigurator.h"

@interface VASAPIConfigurator()

@property (nonatomic, assign) VASAPIConfiguratorType configuratorType;

@end

@implementation VASAPIConfigurator

#pragma mark - Initialize

- (instancetype)initWithBaseURL:(NSURL *)baseURL
                 baseParameters:(id)parameters
{
    if (self = [self initWithConfiguratorType:VASAPIConfiguratorBase]) {
        _baseAPIURL = baseURL;
        _baseParameters = parameters;
    }
    return self;
}

+ (instancetype)baseConfigurator
{
    return [[self alloc] initWithConfiguratorType:VASAPIConfiguratorBase];
}

+ (instancetype)authenticationConfigurator
{
    return [[self alloc] initWithConfiguratorType:VASAPIConfiguratorAuth];
}

- (instancetype)initWithConfiguratorType:(VASAPIConfiguratorType)configuratorType
{
    if (self = [super init]) {
        _configuratorType = configuratorType;
    }
    return self;
}

#pragma mark - Base

- (NSURL *)baseAPIURL
{
    if (_baseAPIURL) {
        return _baseAPIURL;
    }
    
    switch (_configuratorType) {
        case VASAPIConfiguratorBase:
            return [NSURL URLWithString:@"https://api.instagram.com/v1/"];
            break;
        case VASAPIConfiguratorAuth:
            return [NSURL URLWithString:@"https://api.instagram.com/oauth/access_token/"];
        default:
            return [NSURL URLWithString:@"https://api.instagram.com/v1/"];
            break;
    }
}

- (NSDictionary *)baseParameters
{
    switch (_configuratorType)
    {
        case VASAPIConfiguratorBase:
            return @{
                     @"access_token" : [CredentialStorage accessToken]
                     };
            break;
        case VASAPIConfiguratorAuth:
            return @{
                     @"client_id" : self.clientID,
                     @"client_secret" : self.clientSecret,
                     @"grant_type" : self.grantType,
                     @"redirect_uri" : self.redirectURLString
                     };
        default:
            return @{
                     @"access_token" : [CredentialStorage accessToken]
                     };
            break;
    }
}

#pragma mark - Authentication

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

- (NSDictionary *)authenticateBaseParameters
{
    return @{
             @"client_id" : self.clientID,
             @"redirect_uri" : self.redirectURLString,
             @"response_type" : @"code"
             };
}

- (NSString *)authenticateURLString
{
    if (_authenticateURLString) {
        return _authenticateURLString;
    }
    // default
    return @"https://instagram.com/oauth/authorize/";
}

- (NSString *)requestTokenURLString
{
    if (_requestTokenURLString) {
        return _requestTokenURLString;
    }
    // default
    return @"https://api.instagram.com/oauth/access_token/";
}

- (NSString *)redirectURLString
{
    if (_redirectURLString) {
        return _redirectURLString;
    }
    // default
    return @"http://spbvasilenko.github.com";
}


@end
