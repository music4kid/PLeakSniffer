//
//  PLeakingController.m
//  PLeakSniffer
//
//  Created by gao feng on 16/7/5.
//  Copyright © 2016年 gao feng. All rights reserved.
//

#import "PLeakingController.h"

@interface PLeakingController ()
@property (nonatomic, strong) NSTimer*                 timer;

@end

@implementation PLeakingController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(test) userInfo:nil repeats:true];
    
    UIButton* btn = [UIButton new];
    [btn setTitle:@"Close" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor blackColor];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.frame = CGRectMake(self.view.frame.size.width/2-100/2, 200, 100, 50);
    [btn addTarget:self action:@selector(btnCloseClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)test{
    NSLog(@"timer is still alive");
}

- (void)btnCloseClick
{
    [self dismissViewControllerAnimated:true completion:^{
    
    }];
}


@end
