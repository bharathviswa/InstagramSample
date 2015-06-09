//
//  VASNetworkRequestManager.h
//  InstagramSample
//
//  Created by Igor Vasilenko on 09/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VASTemplateRequest;

typedef void(^NetworkRequestCompletionBlockWithSuccess)(id responseObject);
typedef void(^NetworkRequestCompletionBlockWithFailure)(NSError *error);

@interface VASNetworkRequestManager : NSObject

@property (nonatomic, strong) VASTemplateRequest *templateRequest;

- (instancetype)initWithRequestTemplate:(VASTemplateRequest *)templateRequest;

- (void)sendGETWithSuccess:(NetworkRequestCompletionBlockWithSuccess)success
                   failure:(NetworkRequestCompletionBlockWithFailure)failure;

@end
