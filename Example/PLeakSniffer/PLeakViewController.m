//
//  PLeakViewController.m
//  PLeakSniffer
//
//  Created by gao feng on 07/05/2016.
//  Copyright (c) 2016 gao feng. All rights reserved.
//

#import "PLeakViewController.h"
#import "PLeakingController.h"

@interface PLeakViewController ()

@end

@implementation PLeakViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self gotoLeakController];
    });
}

- (void)gotoLeakController
{
    PLeakingController* c = [PLeakingController new];
    [self presentViewController:c animated:true completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
