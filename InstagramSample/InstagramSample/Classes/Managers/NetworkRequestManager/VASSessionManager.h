//
//  VASSessionManager.h
//  InstagramSample
//
//  Created by Igor Vasilenko on 11/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "AFURLSessionManager.h"

@interface VASSessionManager : AFURLSessionManager

- (instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration
                        baseAPICongiguration:(id)baseAPIConfiguration;

- (void)setResultClassForResponse:(Class)resultClass;

- (NSURLSessionDataTask *)dataTaskWithGETMethod:(NSString *)method
                                     parameters:(id)parameters;

@end
