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
#import "SSKeychain.h"

@interface VASHomePageViewModel()

@property (nonatomic, strong) VASResourceManager *resourceManager;

@end

@implementation VASHomePageViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.resourceManager = [[VASResourceManager alloc] init];
        [self loadData];
    }
    return self;
}

- (void)loadData
{
    NSUserDefaults *UD = [NSUserDefaults standardUserDefaults];
    NSString *userID = [UD objectForKey:@"userID"];
    
    @weakify(self);
    [self.resourceManager requestUserInfoWithID:userID
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
                                            
                                    }];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [self.resourceManager requestPopularMediaListWithSuccess:^(NSArray *media) {
            NSLog(@"%d", media.count);
        } failure:^(NSError *error) {
            
        }];
    });
}

- (void)logoutFromAccount
{
    [SSKeychain deletePasswordForService:kKeychainServiceName account:kKeychainAccountName];
    
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (RACCommand *)updatePage
{
    return [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
       
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
           
            [self loadData];

            [subscriber sendNext:nil];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
}

@end
