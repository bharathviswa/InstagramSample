//
//  VASHomePageViewModel.h
//  InstagramSample
//
//  Created by Igor Vasilenko on 09/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VASUser;

@interface VASHomePageViewModel : NSObject

@property (nonatomic, strong) VASUser *user;

@property (nonatomic, strong) NSString *usernameLabelString;
@property (nonatomic, strong) NSString *fullNameLabelString;
@property (nonatomic, strong) NSString *bioLabelString;
@property (nonatomic, strong) NSString *websiteLabelString;
@property (nonatomic, strong) NSString *countPostsLabelString;
@property (nonatomic, strong) NSString *countFollowersLabelString;
@property (nonatomic, strong) NSString *countFollowingLabelString;
@property (nonatomic, strong) UIImage *userPictureImage;

@property (nonatomic, strong) RACCommand *updatePage;

- (void)reloadPage;
- (void)logoutFromAccount;

@end
