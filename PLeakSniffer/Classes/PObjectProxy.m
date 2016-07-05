//
//  PObjectProxy.m
//  PLeakSniffer
//
//  Created by gao feng on 16/7/1.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import "PObjectProxy.h"
#import "NSObject+PLeak.h"

#define kPObjectProxyLeakCheckMaxFailCount      5

static void * PObjectProxyContext = &PObjectProxyContext;

@interface PObjectProxy ()
@property (nonatomic, assign) int                 leakCheckFailCount;
@property (nonatomic, assign) BOOL                hasNotified;

@property (nonatomic, weak) id                    observedObject; //the host actually
@property (nonatomic, strong) NSString*           observedKey;

@end

@implementation PObjectProxy

- (instancetype)init
{
    self = [super init];
    if (self) {
        _leakCheckFailCount = 0;
        _hasNotified = false;
    }
    return self;
}

- (void)prepareProxy:(NSObject*)target {
    self.weakTarget = target;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:Notif_PLeakSniffer_Ping object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detectSnifferPing) name:Notif_PLeakSniffer_Ping object:nil];
    
}


- (void)detectSnifferPing
{
    if (self.weakTarget == nil) {
        return;
    }
    
    if (_hasNotified) {
        return;
    }
    
    BOOL alive = [self.weakTarget isAlive];
    if (alive == false) {
        _leakCheckFailCount ++;
    }
    
    if (_leakCheckFailCount >= kPObjectProxyLeakCheckMaxFailCount) {
        [self notifyPossibleMemoryLeak];
    }
}

- (void)notifyPossibleMemoryLeak
{
    if (_hasNotified) {
        return;
    }
    
    _hasNotified = true;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:Notif_PLeakSniffer_Pong object:self.weakTarget];
    });
}

- (void)observeObject:(id)obj withKeyPath:(NSString*)path withDelegate:(id<PObjectProxyKVODelegate>)delegate
{
    if ([self.observedKey isEqualToString:path]) {
        return;
    }
    
    self.kvoDelegate = delegate;
    self.observedObject = obj;
    self.observedKey = path;
    
    [obj addObserver:self
          forKeyPath:path
             options:NSKeyValueObservingOptionNew
             context:PObjectProxyContext];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if (context == PObjectProxyContext) {
        id newC = [change objectForKey:NSKeyValueChangeNewKey];
        if (newC && _kvoDelegate) {
            [_kvoDelegate didObserveNewValue:newC];
        }
    }
}

- (void)dealloc
{
    
    if (self.observedKey) {
        [_observedObject removeObserver:self forKeyPath:self.observedKey context:PObjectProxyContext];
    }

    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:Notif_PLeakSniffer_Ping object:nil];
}

@end
