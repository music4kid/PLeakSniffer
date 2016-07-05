//
//  UINavigationController+PLeak.m
//  PLeakSniffer
//
//  Created by gao feng on 16/7/1.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import "UINavigationController+PLeak.h"
#import <objc/runtime.h>
#import "NSObject+PLeak.h"

@implementation UINavigationController (PLeak)

+ (void)prepareForSniffer
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleSEL:@selector(pushViewController:animated:) withSEL:@selector(swizzled_pushViewController:animated:)];
    });
}

- (void)swizzled_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    [self swizzled_pushViewController:viewController animated:animated];
    
    [viewController markAlive];
    
}

@end
