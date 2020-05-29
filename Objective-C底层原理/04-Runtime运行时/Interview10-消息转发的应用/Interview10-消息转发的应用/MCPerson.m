//
//  MCPerson.m
//  Interview10-消息转发的应用
//
//  Created by rz-technology on 2020/5/29.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import "MCPerson.h"

@implementation MCPerson

- (void)run
{
    NSLog(@"run-123");
}


/// 方法签名
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    // 本地能调用的方法
    if([self respondsToSelector:aSelector]){
        return [super methodSignatureForSelector:aSelector];
    }
    // 找不到方法
    return [NSMethodSignature signatureWithObjCTypes:"v@:"];
}


/// 找不到方法，都会来到这里
- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    NSLog(@"找不到 %@ 方法",NSStringFromSelector(anInvocation.selector));
}

@end
