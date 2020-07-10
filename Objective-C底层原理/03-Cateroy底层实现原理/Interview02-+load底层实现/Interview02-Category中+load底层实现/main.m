//
//  main.m
//  Interview02-Category中+load底层实现
//
//  Created by rz-technology on 2020/5/22.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCPerson.h"
#import "MCStudent.h"
#import <objc/runtime.h>

void printMethodNamesOfClass(Class cls)
{
    unsigned int count;
    // 获得方法数组
    Method *methodList = class_copyMethodList(cls, &count);
    
    // 存储方法名
    NSMutableString *methodNames = [NSMutableString string];
    
    // 遍历所有的方法
    for (int i = 0; i < count; i++) {
        // 获得方法
        Method method = methodList[i];
        // 获得方法名
        NSString *methodName = NSStringFromSelector(method_getName(method));
        // 拼接方法名
        [methodNames appendString:methodName];
        [methodNames appendString:@", "];
    }
    
    // 释放
    free(methodList);
    
    // 打印方法名
    NSLog(@"%@ %@", cls, methodNames);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        /**
         * + load 方法会在runtime加载类、分类的时候调用
         * 每个类、分类的 + load, 在程序运行过程中只调用一次
         *
         * 调用顺序：
         * 1.先调用类的 + load
         * 按照编译的先后顺序调用（先编译，先调用）
         * 调用子类的 + load 之前会先调用父类的 + load
         *
         * 2.再调用分类的 +load
         * 按照编译的先后顺序调用（先编译、先调用）
         */
    }
    return 0;
}
