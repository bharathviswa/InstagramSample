//
//  VASUser.m
//  InstagramSample
//
//  Created by Igor Vasilenko on 09/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "VASUser.h"

@implementation VASUser

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"uid" : @"id",
             @"userName" : @"username",
             @"fullName" : @"full_name",
             @"biography" : @"bio",
             @"website" : @"website",
             @"profilePicture" : @"profile_picture",
             @"countMedia" : @"counts.media",
             @"countFollowedBy" : @"counts.followed_by",
             @"countFollows" : @"counts.follows"
             };
}

@end
