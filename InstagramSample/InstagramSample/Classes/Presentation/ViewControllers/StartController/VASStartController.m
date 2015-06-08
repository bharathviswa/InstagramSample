//
//  VASStartController.m
//  InstagramSample
//
//  Created by Igor Vasilenko on 08/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "VASStartController.h"

@interface VASStartController ()

@end

@implementation VASStartController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)goAuth:(id)sender
{
    [SimpleAuth authorize:@"instagram" completion:^(id responseObject, NSError *error) {
        NSLog(@"%@", responseObject);
        NSLog(@"%@", error.localizedDescription);
    }];
}

@end
