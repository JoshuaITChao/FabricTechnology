//
//  MCObserver.m
//  Interview05-KVC底层实现原理
//
//  Created by rz-technology on 2020/5/25.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import "MCObserver.h"

@implementation MCObserver

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"observeValueForKeyPath - %@", change);
}

@end
