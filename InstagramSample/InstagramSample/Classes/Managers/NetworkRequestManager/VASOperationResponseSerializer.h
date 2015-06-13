//
//  VASJSONResponseSerializer.h
//  InstagramSample
//
//  Created by Igor Vasilenko on 10/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "AFURLResponseSerialization.h"

@interface VASOperationResponseSerializer : AFJSONResponseSerializer

- (instancetype)initWithResultClass:(Class)resultClass;

@end
