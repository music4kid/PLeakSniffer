//
//  PLeakSniffer.m
//  PLeakSniffer
//
//  Created by gao feng on 16/7/1.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import "PLeakSniffer.h"
#import "UINavigationController+PLeak.h"
#import "UIView+PLeak.h"
#import "UIViewController+PLeak.h"
#import "NSObject+PLeak.h"

#define kPLeakSnifferPingInterval       0.5f

@interface PLeakSniffer ()
@property (nonatomic, strong) NSTimer*                 pingTimer;
@property (nonatomic, assign) BOOL                     useAlert;
@property (nonatomic, strong) NSMutableArray*          ignoreList;

@end

@implementation PLeakSniffer

+ (instancetype)sharedInstance
{
    static PLeakSniffer* instance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [PLeakSniffer new];
    });

    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.ignoreList = @[].mutableCopy;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detectPong:) name:Notif_PLeakSniffer_Pong object:nil];
    }
    return self;
}

- (void)installLeakSniffer {
    [UINavigationController prepareForSniffer];
    [UIViewController prepareForSniffer];
    [UIView prepareForSniffer];
    
    [self startPingTimer];
}

- (void)addIgnoreList:(NSArray*)ignoreList {
    @synchronized (self) {
        for (NSString* item in ignoreList) {
            if ([item isKindOfClass:[NSString class]]) {
                [_ignoreList addObject:item];
            }
        }
    }
}

- (void)alertLeaks {
    _useAlert = true;
}

- (void)startPingTimer
{
    if ([NSThread isMainThread] == false) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self startPingTimer];
            return ;
        });
    }
    
    if (self.pingTimer) {
        return;
    }
    
    self.pingTimer = [NSTimer scheduledTimerWithTimeInterval:kPLeakSnifferPingInterval target:self selector:@selector(sendPing) userInfo:nil repeats:true];
}

- (void)sendPing
{
    [[NSNotificationCenter defaultCenter] postNotificationName:Notif_PLeakSniffer_Ping object:nil];
}

- (void)detectPong:(NSNotification*)notif
{
    NSObject* leakedObject = notif.object;
    NSString* leakedName = NSStringFromClass([leakedObject class]);
    @synchronized (self) {
        if ([_ignoreList containsObject:leakedName]) {
            return;
        }
    }
    
    //we got a leak here
    if (_useAlert) {
        NSString* msg = [NSString stringWithFormat:@"Detect Possible Leak: %@", [leakedObject class]];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"PLeakSniffer" message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
    }
    else
    {
        if ([leakedObject isKindOfClass:[UIViewController class]]) {
            PLeakLog(@"\n\nDetect Possible Controller Leak: %@ \n\n", [leakedObject class]);
        }
        else
        {
            PLeakLog(@"\n\nDetect Possible Leak: %@ \n\n", [leakedObject class]);
        }
    }
}

@end
