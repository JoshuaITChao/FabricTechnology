//
//  main.m
//  Interview11-isKindOfClass和isMemberOfClass
//
//  Created by rz-technology on 2020/5/29.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCPerson.h"
#import <objc/runtime.h>



/**
 * isMemberOfClass和isKindOfClass的内部实现
 * 实例对象调用时
 *     1.1 isMemberOfClass 是通过当前对象的类对象是否等于传入的类对象的方式比较
 *     1.2 isKindOfClass 是同样也是通过以上方法比较，只不过会通过 superclass 遍历寻找下去
 * 类对象调用时
 *     1.1 isMemberOfClass 是通过当前对象的元类对象是否等于传入的元类对象的方式比较
 *     1.2 isKindOfClass 是同样也是通过以上方法比较，只不过会通过 superclass 遍历寻找下去
 */

//@implementation NSObject
//
//- (BOOL)isMemberOfClass:(Class)cls
//{
//    return [self class] == cls;
//}
//
//- (BOOL)isKindOfClass:(Class)cls
//{
//    for (Class tcls = [self class]; tcls; tcls=tcls->superclass) {
//        if(tcls == cls) return YES;
//    }
//    return NO;
//}
//
//
//+ (BOOL)isMemberOfClass:(Class)cls
//{
//    return object_getClass((id)self) == cls;
//}
//
//+ (BOOL)isKindOfClass:(Class)cls
//{
//    for (Class tcls = object_getClass((id)self); tcls; tcls = tcls->superclass) {
//        if(tcls == cls) return YES;
//    }
//    return NO;
//}
//
//@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // NSLog(@"%d", [[NSObject class] isKindOfClass:[NSObject class]]);    // 1
        // NSLog(@"%d", [[NSObject class] isMemberOfClass:[NSObject class]]);  // 0
        // NSLog(@"%d", [[MCPerson class] isKindOfClass:[MCPerson class]]);    // 0
        // NSLog(@"%d", [[MCPerson class] isMemberOfClass:[MCPerson class]]);  // 0
        
        // 这句代码的方法调用者不管是哪个类（只要是NSOject体系下的），都返回YES
        NSLog(@"%d", [NSObject isKindOfClass:[NSObject class]]);    // 1
        NSLog(@"%d", [NSObject isMemberOfClass:[NSObject class]]);  // 0
        NSLog(@"%d", [MCPerson isKindOfClass:[MCPerson class]]);    // 0
        NSLog(@"%d", [MCPerson isMemberOfClass:[MCPerson class]]);  // 0
        
        id person = [[MCPerson alloc] init];
        
        NSLog(@"%d", [person isMemberOfClass:[MCPerson class]]);    // 1
        NSLog(@"%d", [person isMemberOfClass:[NSObject class]]);    // 0
        
        NSLog(@"%d", [person isKindOfClass:[MCPerson class]]);      // 1
        NSLog(@"%d", [person isKindOfClass:[NSObject class]]);      // 1
        
        NSLog(@"%d", [MCPerson isMemberOfClass:object_getClass([MCPerson class])]); // 1
        NSLog(@"%d", [MCPerson isKindOfClass:object_getClass([NSObject class])]);   // 1
        
        NSLog(@"%d", [MCPerson isKindOfClass:[NSObject class]]);    // 1
    }
    return 0;
}
