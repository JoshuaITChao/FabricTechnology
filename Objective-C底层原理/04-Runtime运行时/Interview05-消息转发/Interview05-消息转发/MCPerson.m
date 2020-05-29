//
//  MCPerson.m
//  Interview05-消息转发
//
//  Created by rz-technology on 2020/5/29.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import "MCPerson.h"
#import "MCCat.h"
#import <objc/runtime.h>

@implementation MCPerson

void other(id self, SEL _cmd){
    NSLog(@"- %@ - %@",self, NSStringFromSelector(_cmd));
}


/// 消息动态解析
/// 消息发送阶段没有找到方法，会进入消息动态解析阶段， 如果没有实现 + resolveInstanceMethod / + resolveClassMethod 方法的实现，那么就进入 - forwardingTargetForSelector / + forwardingTargetForSelector方法，如果返回nil则直接报错 unrecognized selector sent to instance，否则进入 - forwardInvocation
//+ (BOOL)resolveInstanceMethod:(SEL)sel
//{
//    if(sel == @selector(test)){
//        class_addMethod(self, sel, (IMP)other, "v:@");
//        return YES;
//    }
//    return [super resolveInstanceMethod:sel];
//}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    if(aSelector == @selector(test)){
        
        return nil;
        
        // objc_msgSend([[MCCat alloc] init], @selector(test))
        // return [[MCCat alloc] init];
    }
    return [super forwardingTargetForSelector:aSelector];
}


/// 方法签名：返回值类型、参数类型
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    if(aSelector == @selector(test)){
        return [NSMethodSignature signatureWithObjCTypes:"v:@"];
    }
    return [super methodSignatureForSelector:aSelector];
}


/// NSInvocation封装了一个方法的调用，包括：方法调用者、方法名、方法参数
///     anInvocation.target：方法调用者
///     anInvocation.selector：方法名
- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    
    NSLog(@"%@", anInvocation.target);
    NSLog(@"%@", NSStringFromSelector(anInvocation.selector));
    id receiver;
    SEL sel;
    [anInvocation getArgument:&receiver atIndex:0];
    [anInvocation getArgument:&sel atIndex:1];
    NSLog(@"%@", receiver);
    NSLog(@"%@", NSStringFromSelector(sel));
    
//    anInvocation.target = [[MCCat alloc] init];
//    anInvocation.selector = @selector(print);
//    [anInvocation invoke];
    
    [anInvocation invokeWithTarget:[[MCCat alloc] init]];
    
}


@end
