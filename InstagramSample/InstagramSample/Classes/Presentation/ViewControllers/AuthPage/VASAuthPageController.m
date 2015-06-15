//
//  VASAuthViewController.m
//  InstagramSample
//
//  Created by Igor Vasilenko on 14/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "VASAuthPageController.h"

#import "VASAuthPageViewModel.h"
#import "SSKeychain.h"

@interface VASAuthPageController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) VASAuthPageViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation VASAuthPageController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.viewModel = [VASAuthPageViewModel new];
    
    self.webView.delegate = self;
    [self.webView loadRequest:self.viewModel.authenticationURLRequest];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([request.URL.absoluteString hasPrefix:kInstagramAPIRedirectUrl])
    {
        [self.activityIndicator startAnimating];
        
        NSArray *componentsURL = [request.URL.absoluteString componentsSeparatedByString:@"/?code="];
        NSString *responseCode = componentsURL[1];
        
        if (responseCode) {
            self.webView.alpha = 0;
            [self.viewModel requestAccessTokenWithResponseCode:responseCode
                                                       success:^(BOOL success) {
                                                           if (success) {
                                                               [self.activityIndicator stopAnimating];
                                                               UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                                                               UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"homePage"];
                                                               UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
                                                               [self presentViewController:navController animated:YES completion:nil];
                                                           }
                                                           else
                                                           {
                                                               [self.activityIndicator stopAnimating];
                                                               [self dismissViewControllerAnimated:YES completion:nil];
                                                           }
                                                       } failure:^(NSError *error) {
                                                           if (error) {
                                                               // show alert
                                                           }
                                                       }];
        }
    }
    
    return YES;
}

@end
