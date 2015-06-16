//
//  VASCredentialStorage.m
//  InstagramSample
//
//  Created by Igor Vasilenko on 16/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "VASCredentialStorage.h"

#import "SSKeychain.h"

@implementation VASCredentialStorage

+ (instancetype)sharedInstance
{
    static VASCredentialStorage *sharedInstance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

#pragma mark - Properties

- (void)setCurrentAuthenticatedUserID:(NSString *)currentAuthenticatedUserID
{
    [[NSUserDefaults standardUserDefaults] setObject:currentAuthenticatedUserID forKey:@"userID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)currentAuthenticatedUserID
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
}

- (void)setAccessToken:(NSString *)accessToken
{
    [SSKeychain setPassword:accessToken
                 forService:kKeychainServiceName
                    account:kKeychainAccountName];
}

- (NSString *)accessToken
{
    return [SSKeychain passwordForService:kKeychainServiceName
                                  account:kKeychainAccountName];
}

#pragma mark - Helper methods

- (void)clearCookies
{
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)resetAccessToken
{
    [SSKeychain deletePasswordForService:kKeychainServiceName
                                 account:kKeychainAccountName];
}

@end
