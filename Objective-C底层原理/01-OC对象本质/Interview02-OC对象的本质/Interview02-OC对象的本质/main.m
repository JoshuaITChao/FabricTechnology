//
//  main.m
//  Interview02-OC对象的本质
//
//  Created by rz-technology on 2020/5/15.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <malloc/malloc.h>

struct NSObject_IMPL {
    Class isa;
};

// OC对象的本地，底层的Student用什么表示？
struct Student_IMPL {
    struct NSObject_IMPL NSObject_IVARS;
    int _no;
    int _age;
};



@interface Student : NSObject
{
    @public
    int _no;
    int _age;
}
@end

@implementation Student

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Student *stu = [[Student alloc] init];
        stu->_no = 4;
        stu->_age = 29;
        
        NSLog(@"%zd",class_getInstanceSize([Student class]));
        NSLog(@"%zd",malloc_size((__bridge const void *)stu));
        
        struct Student_IMPL *stuImpl = (__bridge struct Student_IMPL *)stu;
        NSLog(@"no is %d, age is %d", stuImpl->_no, stuImpl->_age);
    }
    return 0;
}
