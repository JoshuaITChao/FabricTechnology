//
//  UIControl+Extension.m
//  Interview16-方法交换的使用场景
//
//  Created by rz-technology on 2020/6/1.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import "UIControl+Extension.h"
#import <objc/runtime.h>

@implementation UIControl (Extension)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 钩子函数
        Method method1 = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
        Method method2 = class_getInstanceMethod(self, @selector(mc_sendAction:to:forEvent:));
        
        method_exchangeImplementations(method1, method2);
    });
    
}

- (void)mc_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    NSLog(@"%@-%@-%@", self, target, NSStringFromSelector(action));
    
    // 调用系统原来的事件
    [self mc_sendAction:action to:target forEvent:event];
    
    if([self isKindOfClass:[UIButton class]]){
        // 拦截所有按钮的事件
        NSLog(@"已拦截到按钮 %@ 点击事件", self);
    }
}

@end
