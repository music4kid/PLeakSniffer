//
//  PLeakSniffer.h
//  PLeakSniffer
//
//  Created by gao feng on 16/7/1.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PLeakLog(format, ...) NSLog(format, ##__VA_ARGS__)

#define Notif_PLeakSniffer_Ping @"Notif_PLeakSniffer_Ping"
#define Notif_PLeakSniffer_Pong @"Notif_PLeakSniffer_Pong"

@protocol PLeakSnifferCitizen <NSObject>

+ (void)prepareForSniffer;

- (BOOL)markAlive;

- (BOOL)isAlive;

@end

@interface PLeakSniffer : NSObject

+ (instancetype)sharedInstance;

- (void)installLeakSniffer;
- (void)addIgnoreList:(NSArray*)ignoreList;
- (void)alertLeaks; //use UIAlertView to notify leaks

@end
