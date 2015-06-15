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

@end

@implementation VASAuthPageController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.viewModel = [VASAuthPageViewModel new];
    
    self.webView.delegate = self;
    [self.webView loadRequest:self.viewModel.authUrlRequest];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    if ([request.URL.absoluteString hasPrefix:kInstagramAPIRedirectUrl]) {
        NSArray *componentsURL = [request.URL.absoluteString componentsSeparatedByString:@"/?code="];
        NSString *responseCode = componentsURL[1];
        
        if (responseCode) {
            [self.viewModel requestAccessTokenWithResponseCode:responseCode
                                                       success:^(BOOL success) {
                                                           if (success) {
                                                               UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                                                               UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"homePage"];
                                                               UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
                                                               [self presentViewController:navController animated:YES completion:nil];
                                                           }
                                                       } failure:^(NSError *error) {
                                                           if (error) {
                                                               [self dismissViewControllerAnimated:YES completion:nil];
                                                           }
                                                       }];
        }
    }
    
    return YES;
}

@end
