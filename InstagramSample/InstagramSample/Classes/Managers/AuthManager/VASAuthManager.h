//
//  VASAuthManager.h
//  InstagramSample
//
//  Created by Igor Vasilenko on 08/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^AuthCompletionBlockWithSuccess)(BOOL authorize);
typedef void(^AuthCompletionBlockWithFailure)(NSError *error);

@interface VASAuthManager : NSObject

- (void)authorizeUserWithSuccess:(AuthCompletionBlockWithSuccess)success
                         failure:(AuthCompletionBlockWithFailure)failure;

@end
