//
//  VASHomePageViewModel.m
//  InstagramSample
//
//  Created by Igor Vasilenko on 09/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "VASHomePageViewModel.h"

#import "VASResourceManager.h"
#import "VASUser.h"

@interface VASHomePageViewModel()

@property (nonatomic, strong) VASResourceManager *resourceManager;
@property (nonatomic, strong) RACSubject *errorSubject;

@end

@implementation VASHomePageViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.resourceManager = [[VASResourceManager alloc] init];
        self.errorSubject = [RACSubject subject];
        [self loadData];
    }
    return self;
}

- (void)loadData
{
    @weakify(self);
    [self.resourceManager userInfoWithID:[CredentialStorage currentAuthenticatedUserID]
                                 success:^(VASUser *user) {
                                     @strongify(self);
                                     if (user) {
                                         self.user = user;
                                         
                                         self.usernameLabelString = self.user.userName;
                                         self.fullNameLabelString = self.user.fullName;
                                         self.bioLabelString = self.user.biography;
                                         self.websiteLabelString = self.user.website;
                                         self.countPostsLabelString = [NSString stringWithFormat:@"%@", self.user.countMedia];
                                         self.countFollowersLabelString = [NSString stringWithFormat:@"%@", self.user.countFollowedBy];
                                         self.countFollowingLabelString = [NSString stringWithFormat:@"%@", self.user.countFollows];
                                         self.userPictureImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.user.profilePicture]]];
                                     }
                                     
                                 } failure:^(NSError *error) {
                                     [self.errorSubject sendNext:error];
                                 }];
    
    [self.resourceManager userFollowsListWithID:[CredentialStorage currentAuthenticatedUserID]
                                        success:^(id responseObject) {
                                            NSLog(@"%@", responseObject);
                                        } failure:^(NSError *error) {
                                            
                                        }];
}

- (void)logoutFromAccount
{
    [CredentialStorage clearCookies];
    [CredentialStorage resetAccessToken];
}

- (void)reloadPage
{
    [self loadData];
}

- (RACSignal *)errorSignal
{
    return self.errorSubject;
}

@end
