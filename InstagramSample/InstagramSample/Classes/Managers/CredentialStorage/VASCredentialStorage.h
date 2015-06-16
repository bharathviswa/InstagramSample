//
//  VASCredentialStorage.h
//  InstagramSample
//
//  Created by Igor Vasilenko on 16/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CredentialStorage [VASCredentialStorage sharedInstance]

@interface VASCredentialStorage : NSObject

@property (nonatomic, strong) NSString *currentAuthenticatedUserID;
@property (nonatomic, strong) NSString *accessToken;

+ (instancetype)sharedInstance;

- (void)clearCookies;
- (void)resetAccessToken;

@end
