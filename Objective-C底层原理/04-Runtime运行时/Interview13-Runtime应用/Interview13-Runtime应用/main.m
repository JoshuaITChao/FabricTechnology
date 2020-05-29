//
//  main.m
//  Interview13-Runtime应用
//
//  Created by rz-technology on 2020/5/29.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCPerson.h"
#import "MCStudent.h"
#import "MCCar.h"
#import "NSObject+Json.h"
#import <objc/runtime.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // 字典转模型
        NSDictionary *json = @{
            @"id": @20,
            @"age": @20,
            @"weight": @60,
            @"name": @"Jack"
        };
        MCPerson *person = [MCPerson mc_objectWithJson:json];
        
       
    }
    return 0;
}

void testIvars()
{
    // 获取成员变量信息
    Ivar ageIvar = class_getInstanceVariable([MCPerson class], "_age");
    NSLog(@"%s %s", ivar_getName(ageIvar), ivar_getTypeEncoding(ageIvar));

    NSLog(@"--------------------");

    // 设置和获取成员变量的值
    Ivar nameIvar = class_getInstanceVariable([MCPerson class], "_name");
    MCPerson *person = [[MCPerson alloc] init];
    object_setIvar(person, nameIvar, @"123");
    object_setIvar(person, ageIvar, (__bridge id)(void *)10);
    NSLog(@"%@ %d", person.name, person.age);

    NSLog(@"--------------------");

    unsigned int count;
    Ivar *ivars = class_copyIvarList([MCPerson class], &count);
    for (int i=0; i<count; i++) {
       // 取出i位置的成员变量
       Ivar ivar = ivars[i];
       NSLog(@"%s %s", ivar_getName(ivar), ivar_getTypeEncoding(ivar));
    }
}



void run(id self, SEL _cmd) {
    NSLog(@" - %@ - %@",self, NSStringFromSelector(_cmd));
}

void testClass()
{
    // 动态创建类
    Class newCls = objc_allocateClassPair([NSObject class], "MCDog", 0);
    class_addIvar(newCls, "_age", 4, 1, @encode(int));
    class_addIvar(newCls, "_weight", 4, 1, @encode(int));
    class_addMethod(newCls, @selector(run), (IMP)run, "v@:");
    // 注意：如果要添加成员变量或者方法，要在注册类之前添加
    objc_registerClassPair(newCls);
    
    // 方法的调用
    id dog = [[newCls alloc] init];
    [dog setValue:@10 forKey:@"_age"];
    [dog setValue:@20 forKey:@"_weight"];
    [dog run];
    
    NSLog(@"%@  %@",[dog valueForKey:@"_age"], [dog valueForKey:@"_weight"]);
}


void test()
{
    MCPerson *person = [[MCPerson alloc] init];
    [person run];
    
    object_setClass(person, [MCCar class]);
    [person run];
    
    NSLog(@"%d %d %d",
          object_isClass(person),
          object_isClass([MCPerson class]),
          object_isClass(object_getClass([MCPerson class])));
}
