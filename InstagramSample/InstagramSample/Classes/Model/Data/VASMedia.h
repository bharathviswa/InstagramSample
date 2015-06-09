//
//  VASMedia.h
//  InstagramSample
//
//  Created by Igor Vasilenko on 09/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "MTLModel.h"

@interface VASMedia : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSDate *createdTime;
@property (nonatomic, strong) NSString *standardImageLink;
@property (nonatomic, strong) NSString *thumbailImageLink;

@property (nonatomic, strong) NSArray *likes;
@property (nonatomic, strong) NSArray *comments;
@property (nonatomic, strong) NSArray *tags;

@end
