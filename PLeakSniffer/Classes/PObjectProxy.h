//
//  PObjectProxy.h
//  PLeakSniffer
//
//  Created by gao feng on 16/7/1.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PObjectProxyKVODelegate <NSObject>

- (void)didObserveNewValue:(id)value;

@end

@interface PObjectProxy : NSObject

- (void)prepareProxy:(NSObject*)target;

@property (nonatomic, weak) NSObject*                 weakTarget;
@property (nonatomic, weak) NSObject*                 weakHost;
@property (nonatomic, weak) NSObject*                 weakResponder;

@property (nonatomic, weak) id<PObjectProxyKVODelegate>                 kvoDelegate;

- (void)observeObject:(id)obj withKeyPath:(NSString*)path withDelegate:(id<PObjectProxyKVODelegate>)delegate;

@end
