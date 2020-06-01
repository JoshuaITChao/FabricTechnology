//
//  NSMutableDictionary+Extension.m
//  Interview16-方法交换的使用场景
//
//  Created by rz-technology on 2020/6/1.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import "NSMutableDictionary+Extension.h"
#import <objc/runtime.h>

@implementation NSMutableDictionary (Extension)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class cls = NSClassFromString(@"__NSDictionaryM");
        Method method1 = class_getInstanceMethod(cls, @selector(setObject:forKeyedSubscript:));
        Method method2 = class_getInstanceMethod(cls, @selector(mc_setObject:forKeyedSubscript:));
        method_exchangeImplementations(method1, method2);
        
        Class cls2 = NSClassFromString(@"__NSDictionaryI");
        Method method3 = class_getInstanceMethod(cls2, @selector(objectForKeyedSubscript:));
        Method method4 = class_getInstanceMethod(cls2, @selector(mc_objectForKeyedSubscript:));
        method_exchangeImplementations(method3, method4);
        
    });
}

- (void)mc_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key
{
    if(!key || !obj) return;
    [self mc_setObject:obj forKeyedSubscript:key];
}

- (id)mc_objectForKeyedSubscript:(id)key
{
    if(!key) return nil;
    return [self mc_objectForKeyedSubscript:key];
}

@end
