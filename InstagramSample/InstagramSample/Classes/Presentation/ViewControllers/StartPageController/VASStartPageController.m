//
//  VASStartPageController.m
//  InstagramSample
//
//  Created by Igor Vasilenko on 14/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "VASStartPageController.h"

#import "SSKeychain.h"
#import "VASAuthenticationConfigurator.h"

@interface VASStartPageController ()

@end

@implementation VASStartPageController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)goToAuthPage:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    NSString *password = [SSKeychain passwordForService:kKeychainServiceName
                                                account:kKeychainAccountName];
    
    if (password)
    {
        UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"homePage"];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
        [self presentViewController:navController animated:YES completion:nil];
    }
    else
    {
        UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"authPage"];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
        [self presentViewController:navController animated:YES completion:nil];
    }
}

@end
