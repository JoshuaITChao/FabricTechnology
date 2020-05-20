//
//  main.m
//  Interview03-OC对象本质
//
//  Created by rz-technology on 2020/5/15.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <malloc/malloc.h>

// 底层实现

struct NSObject_IMPL {
    Class isa;
};

struct Person_IMPL {
    struct NSObject_IMPL NSObject_IVARS;    // 8
    int _age;       // 4
    int _height;    // 4
    int _width;     // 4
};  // 24 内存对齐：结构体的大小必须是最大成员大小的倍数

struct Student_IMPL {
    struct Person_IMPL Person_IVARS;    // 24
    int _no;    // 4
}; // 32



@interface Person : NSObject
{
    @public
    int _age;
}
@property (nonatomic, assign) int height;
@property (nonatomic, assign) int width;
@end

@implementation Person

@end

@interface Student : Person
{
    @public
    int _no;
    int _sex;
}
@end

@implementation Student

@end


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Student *stu = [[Student alloc] init];
        NSLog(@"Student %zd",class_getInstanceSize([Student class]));
        NSLog(@"Student %zd",malloc_size((__bridge const void *)stu));
        
        
        Person *person = [[Person alloc] init];
        [person setHeight:10];
        [person height];
        person->_age = 29;
        NSLog(@"Person %zd",class_getInstanceSize([Person class]));
        NSLog(@"Person %zd",malloc_size((__bridge const void *)person));
        
    }
    return 0;
}
