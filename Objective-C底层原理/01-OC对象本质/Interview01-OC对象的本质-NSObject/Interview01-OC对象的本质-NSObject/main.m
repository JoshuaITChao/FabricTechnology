//
//  main.m
//  Interview01-OC对象的本质-NSObject
//
//  Created by rz-technology on 2020/5/15.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <malloc/malloc.h>

// NSObject Implemnetion
struct NSObject_IMPL {
    Class isa;  // 8个字节
};

// Class是什么类型？
// 结构体指针
//typedef struct objc_class *Class;


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSObject *obj = [[NSObject alloc] init];
        // 16个字节
        
        // 获的NSObject实例对象的成员变量所占用的大小 >> 8
        NSLog(@"%zd",class_getInstanceSize([NSObject class]));
        
        // 获得obj指针所指向内存的大小 >> 16
        NSLog(@"%zd",malloc_size((__bridge const void *)obj));
        
        // 什么平台的代码
        // 不同平台支持的代码肯定不一样
        // Windows、mac、iOS
        // 模拟器(i386)、32bit(armv7)、64bit(arm64)
        
    }
    return 0;
}
