//
//  VASHomePageController.m
//  InstagramSample
//
//  Created by Igor Vasilenko on 09/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "VASHomePageController.h"

#import "VASHomePageViewModel.h"

@interface VASHomePageController ()

@property (nonatomic, strong) VASHomePageViewModel *viewModel;

@property (weak, nonatomic) IBOutlet UIImageView *userPictureImageView;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bioLabel;
@property (weak, nonatomic) IBOutlet UILabel *websiteLabel;
@property (weak, nonatomic) IBOutlet UILabel *countPostsLabel;
@property (weak, nonatomic) IBOutlet UILabel *countFollowersLabel;
@property (weak, nonatomic) IBOutlet UILabel *countFollowingLabel;

@end

@implementation VASHomePageController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _viewModel = [VASHomePageViewModel new];
    [self bindUI];
}

- (void)bindUI
{
    RAC(self.userPictureImageView, image) = RACObserve(self.viewModel, userPictureImage);
    RAC(self.fullNameLabel, text) = RACObserve(self.viewModel, fullNameLabelString);
    RAC(self.bioLabel, text) = RACObserve(self.viewModel, bioLabelString);
    RAC(self.websiteLabel, text) = RACObserve(self.viewModel, websiteLabelString);
    RAC(self.countPostsLabel, text) = RACObserve(self.viewModel, countPostsLabelString);
    RAC(self.countFollowersLabel, text) = RACObserve(self.viewModel, countFollowersLabelString);
    RAC(self.countFollowingLabel, text) = RACObserve(self.viewModel, countFollowingLabelString);
}

@end
