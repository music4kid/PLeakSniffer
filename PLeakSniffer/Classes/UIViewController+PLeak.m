//
//  UIViewController+PLeak.m
//  PLeakSniffer
//
//  Created by gao feng on 16/7/1.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import "UIViewController+PLeak.h"
#import <objc/runtime.h>
#import "NSObject+PLeak.h"
#import "NSObject+PLeakTrack.h"

@implementation UIViewController (PLeak)

+ (void)prepareForSniffer
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleSEL:@selector(presentViewController:animated:completion:) withSEL:@selector(swizzled_presentViewController:animated:completion:)];
        [self swizzleSEL:@selector(viewDidAppear:) withSEL:@selector(swizzled_viewDidAppear:)];
    });
}

- (void)swizzled_presentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^)(void))completion
{
    [self swizzled_presentViewController:viewControllerToPresent animated:flag completion:completion];
    
    [viewControllerToPresent markAlive];
}

- (void)swizzled_viewDidAppear:(BOOL)animated
{
    [self swizzled_viewDidAppear:animated];
    
    //a good time to start watch properties
    [self watchAllRetainedProperties:0];
}

- (BOOL)isAlive
{
    BOOL alive = true;
    
    BOOL visibleOnScreen = false;

    UIView* v = self.view;
    while (v.superview != nil) {
        v = v.superview;
    }
    if ([v isKindOfClass:[UIWindow class]]) {
        visibleOnScreen = true;
    }
    
    
    BOOL beingHeld = false;
    if (self.navigationController != nil || self.presentingViewController != nil) {
        beingHeld = true;
    }
    
    //not visible, not in view stack
    if (visibleOnScreen == false && beingHeld == false) {
        alive = false;
    }
    
    if (alive == false) {
//        PLeakLog(@"leaked object: %@ ?", [self class]);
    }
    
    
    return alive;
}



@end
