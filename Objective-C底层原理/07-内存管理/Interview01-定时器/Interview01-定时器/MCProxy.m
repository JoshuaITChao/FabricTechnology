//
//  MCProxy.m
//  Interview01-定时器
//
//  Created by rz-technology on 2020/7/8.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import "MCProxy.h"

@implementation MCProxy

+ (instancetype)proxyWithTarget:(id)target
{
    // NSProxy对象不需要调用init，因为它本来就没有init方法
    MCProxy *proxy = [MCProxy alloc];
    proxy.target = target;
    return proxy;
}

/**
 * 注意：
 * NSProxy对象特殊，消息转发阶段，不调用 forwardingTargetForSelector 方法
 * 只调用 methodSignatureForSelector 和 forwardInvocation 两个方法
 */

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    [invocation invokeWithTarget:self.target];
}

@end
