//
//  main.m
//  Interview03-+initialize底层实现
//
//  Created by rz-technology on 2020/5/22.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCPerson.h"
#import "MCStudent.h"
#import "MCTeacher.h"
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
        
        [MCStudent alloc];
        
        // 模拟[MCStudent alloc]触发+initialized的底层逻辑
        BOOL studentInitialized = NO;
        BOOL personIntialized = NO;
        BOOL teacherInitialized = NO;
        
        if(!studentInitialized){
            if(!personIntialized){
                objc_msgSend([MCPerson class], @selector(initialize));
                personIntialized = YES;
            }
            objc_msgSend([MCStudent class], @selector(initialize));
            studentInitialized = YES;
        }
    }
    return 0;
}
