//
//  VASUser.h
//  InstagramSample
//
//  Created by Igor Vasilenko on 09/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "MTLModel.h"

@interface VASUser : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *fullName;

@property (nonatomic, strong) NSString *biography;
@property (nonatomic, strong) NSString *website;
@property (nonatomic, strong) NSString *profilePicture;

@property (nonatomic, strong) NSNumber *countMedia;
@property (nonatomic, strong) NSNumber *countFollowedBy;
@property (nonatomic, strong) NSNumber *countFollows;

@end
