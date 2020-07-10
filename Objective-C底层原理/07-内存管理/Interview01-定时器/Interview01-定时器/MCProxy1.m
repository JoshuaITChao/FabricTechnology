//
//  MCProxy1.m
//  Interview01-定时器
//
//  Created by rz-technology on 2020/7/8.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import "MCProxy1.h"

@implementation MCProxy1

+ (instancetype)proxyWithTarget:(id)target
{
    MCProxy1 *proxy = [[MCProxy1 alloc] init];
    proxy.target = target;
    return proxy;
}

/**
 * 这里实现消息转发，完成target方法的调用
 */
- (id)forwardingTargetForSelector:(SEL)aSelector
{
    return self.target;
}

@end
