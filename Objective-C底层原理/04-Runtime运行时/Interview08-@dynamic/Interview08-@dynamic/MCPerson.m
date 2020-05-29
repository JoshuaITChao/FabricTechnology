//
//  MCPerson.m
//  Interview08-@dynamic
//
//  Created by rz-technology on 2020/5/29.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import "MCPerson.h"
#import <objc/runtime.h>

@implementation MCPerson


/// 提醒编译器不要自动生成setter和getter的实现，不要自动生成成员变量
@dynamic age;

void setAge(id self, SEL _cmd, int age)
{
    NSLog(@"age is %d", age);
}

int age(id self, SEL _cmd)
{
    return 120;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if(sel == @selector(setAge:)){
        class_addMethod(self, sel, (IMP)setAge, "v@:i");
        return YES;
    }else if (sel == @selector(age)){
        class_addMethod(self, sel, (IMP)age, "i@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

// 系统自动生成
//@synthesize age=_age, height=_height;
//- (void)setAge:(int)age
//{
//    _age = age;
//}
//- (int)age
//{
//    return _age;
//}

@end
