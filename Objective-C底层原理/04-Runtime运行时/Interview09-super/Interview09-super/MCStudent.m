//
//  MCStudent.m
//  Interview09-super
//
//  Created by rz-technology on 2020/5/29.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import "MCStudent.h"
#import <objc/runtime.h>

@implementation MCStudent

/**
 * [super messsage]的底层实现
 *  1.消息接收者仍然是子类对象
 *  2.从父类开始查找方法的实现
 */

struct objc_super {
    __unsafe_unretained _Nonnull id receiver;       // 消息接收者
    __unsafe_unretained _Nonnull Class super_class; // 消息接收者的父类
};

- (void)run
{
    // super调用的receiver仍然是MCStudent对象
    [super run];
    
//    struct objc_super arg = { self, [MCPerson class] };
//    objc_msgSendSuper(arg, @selector(run));
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSLog(@"[self class] = %@",[self class]);               // MCStudent
        NSLog(@"[self superclass] = %@", [self superclass]);    // MCPerson
        
        NSLog(@"----------------");
        
        NSLog(@"[super class] = %@", [super class]);            // MCStudent
        NSLog(@"[super superclass] = %@", [super superclass]);  // MCPerson
        
    }
    return self;
}

@end

//@implementation NSObject
//
//// class的内部实现
//- (Class)class
//{
//    return object_getClass(self);
//}
//
//// class的内部实现
//- (Class)superclass
//{
//    return class_getSuperclass(object_getClass(self));
//}
//
//@end
