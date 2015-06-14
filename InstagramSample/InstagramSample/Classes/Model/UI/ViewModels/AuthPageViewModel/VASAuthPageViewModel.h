//
//  VASAuthPageViewModel.h
//  InstagramSample
//
//  Created by Igor Vasilenko on 14/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^AuthPageViewModelCompletionBlockWithSuccess)(BOOL success);
typedef void(^AuthPageViewModelCompletionBlockWithFailure)(NSError *error);

@interface VASAuthPageViewModel : NSObject

@property (nonatomic, strong) NSURLRequest *authUrlRequest;

- (void)requestAccessTokenWithResponseCode:(NSString *)responseCode
                                   success:(AuthPageViewModelCompletionBlockWithSuccess)success
                                   failure:(AuthPageViewModelCompletionBlockWithFailure)failure;

@end
