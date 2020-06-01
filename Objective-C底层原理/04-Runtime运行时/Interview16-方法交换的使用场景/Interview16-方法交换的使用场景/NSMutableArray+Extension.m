//
//  NSMutableArray+Extension.m
//  Interview16-方法交换的使用场景
//
//  Created by rz-technology on 2020/6/1.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import "NSMutableArray+Extension.h"
#import <objc/runtime.h>


@implementation NSMutableArray (Extension)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // 类簇：NSString、NSArray、NSDictionary,真实类型是其他类型
        Class cls = NSClassFromString(@"__NSArrayM");
        Method method1 = class_getInstanceMethod(cls, @selector(insertObject:atIndex:));
        Method method2 = class_getInstanceMethod(cls, @selector(mc_insertObject:atIndex:));
        method_exchangeImplementations(method1, method2);
    });
}

- (void)mc_insertObject:(id)anObject atIndex:(NSUInteger)index
{
    if(anObject == nil) return;
    
    [self mc_insertObject:anObject atIndex:index];
}

@end
