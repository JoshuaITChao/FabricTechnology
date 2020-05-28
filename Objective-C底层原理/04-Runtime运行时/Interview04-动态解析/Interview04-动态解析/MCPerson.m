//
//  MCPerson.m
//  Interview04-动态解析
//
//  Created by rz-technology on 2020/5/28.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import "MCPerson.h"
#import <objc/runtime.h>


@implementation MCPerson

/// 调用objc_msgSend经历的3个阶段
/// 1.消息发送
///   1.1 先从cls的cache中查找，如果找到直接返回的调用
///   1.2 如果cls的cache中没有，那么会从cls的类对象的rw_t中查找，如果找到了，先缓存到cache中，在返回方法的调用
///   1.3 通过superclass中一直重复上述操作
///   1.4 如果没有找到，那么会进行动态解析
/// 2.动态解析
///   2.1 先调用 resolveInstanceMethod / resolveClassMethod 处理实例方法和类方法
///   2.2 如果 resolveInstanceMethod / resolveClassMethod 没事实现，那么会进入 + / - forwardingTargetForSelector方法
///   2.3 如果 + / - forwardingTargetForSelector 返回nil，则报错提示找不到方法，否则进入 - forwardInvocation 方法
/// 3.消息转发

/**
 * 实现方式一：
 */

//void c_other(id self, SEL _cmd)
//{
//    NSLog(@"c_other - %@ - %@",self, NSStringFromSelector(_cmd));
//}

//+ (BOOL)resolveInstanceMethod:(SEL)sel
//{
//    if(sel == @selector(test)){
//        // 动态添加test的方法实现
//        class_addMethod(self, sel, (IMP)c_other, "v@:");
//        // 返回YES代表有动态添加方法
//        return YES;
//    }
//    return [super resolveInstanceMethod:sel];
//}


/**
 * 实现方式二：
 */

//struct method_t {
//    SEL sel;
//    char *types;
//    IMP imp;
//};
//
//- (void)other
//{
//    NSLog(@"%s", __func__);
//}

//+ (BOOL)resolveInstanceMethod:(SEL)sel
//{
//    if(sel == @selector(test)){
//        // 获取其他方法
//        struct method_t *method = (struct method_t *)class_getInstanceMethod(self, @selector(other));
//
//        // 动态添加 test 方法的实现
//        class_addMethod(self, sel, method->imp, method->types);
//
//        // 返回YE代表有动态添加方法
//        return YES;
//    }
//    return [super resolveInstanceMethod:sel];
//}


/**
 * 方式三
 */

- (void)other
{
    NSLog(@"%s", __func__);
}

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if(sel == @selector(test)){
        // 获取其他方法
        Method method = class_getInstanceMethod(self, @selector(other));
        
        // 动态添加test方法
        class_addMethod(self, sel, method_getImplementation(method), method_getTypeEncoding(method));
        
        // 返回YES代表有动态添加方法
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}


@end
