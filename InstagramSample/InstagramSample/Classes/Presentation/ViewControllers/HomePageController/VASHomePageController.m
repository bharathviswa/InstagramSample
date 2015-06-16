//
//  VASHomePageController.m
//  InstagramSample
//
//  Created by Igor Vasilenko on 09/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "VASHomePageController.h"

#import "VASHomePageViewModel.h"
#import "SSKeychain.h"

@interface VASHomePageController ()

@property (nonatomic, strong) VASHomePageViewModel *viewModel;

@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

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
    
    self.refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.frame.size.width, 0)];
    [self.refreshControl addTarget:self action:@selector(reloadPage) forControlEvents:UIControlEventValueChanged];
    [self.scrollView addSubview:self.refreshControl];
    self.refreshControl.rac_command = self.viewModel.updatePage;
    
    _viewModel = [VASHomePageViewModel new];
    [self bindUI];
}

- (void)bindUI
{
    self.userPictureImageView.layer.masksToBounds = YES;
    self.userPictureImageView.layer.cornerRadius = self.userPictureImageView.frame.size.width/2;
    
    RAC(self, title) = RACObserve(self.viewModel, usernameLabelString.uppercaseString);
    RAC(self.userPictureImageView, image) = RACObserve(self.viewModel, userPictureImage);
    RAC(self.fullNameLabel, text) = RACObserve(self.viewModel, fullNameLabelString);
    RAC(self.bioLabel, text) = RACObserve(self.viewModel, bioLabelString);
    RAC(self.websiteLabel, text) = RACObserve(self.viewModel, websiteLabelString);
    RAC(self.countPostsLabel, text) = RACObserve(self.viewModel, countPostsLabelString);
    RAC(self.countFollowersLabel, text) = RACObserve(self.viewModel, countFollowersLabelString);
    RAC(self.countFollowingLabel, text) = RACObserve(self.viewModel, countFollowingLabelString);
}

- (void)reloadPage
{
    [self.viewModel reloadPage];
    [self.refreshControl endRefreshing];
}

- (IBAction)logout:(id)sender
{
    [self.viewModel logoutFromAccount];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"startPage"];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:navController animated:YES completion:nil];
}

@end
