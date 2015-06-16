//
//  VASStartPageController.m
//  InstagramSample
//
//  Created by Igor Vasilenko on 14/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "VASStartPageController.h"

#import "SSKeychain.h"

@interface VASStartPageController ()

@property (weak, nonatomic) IBOutlet UIButton *authButton;

@end

@implementation VASStartPageController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.authButton.layer.masksToBounds = YES;
    self.authButton.layer.cornerRadius = 15;
}

- (IBAction)goToAuthPage:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    NSString *accessToken = [CredentialStorage accessToken];
    
    if (accessToken)
    {
        UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"homePage"];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
        [self presentViewController:navController animated:YES completion:nil];
    }
    else
    {
        UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"authPage"];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

@end
