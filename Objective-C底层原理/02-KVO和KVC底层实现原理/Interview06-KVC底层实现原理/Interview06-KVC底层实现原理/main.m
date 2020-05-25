//
//  main.m
//  Interview06-KVC底层实现原理
//
//  Created by rz-technology on 2020/5/25.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCPerson.h"
#import "MCObserver.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
     
        MCObserver *observer= [[MCObserver alloc] init];
        MCPerson *person = [[MCPerson alloc] init];
        
        // 添加KVO监听
        [person addObserver:observer forKeyPath:@"age" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
        
        // 通过KVC修改age属性
        // [person setValue:@10 forKey:@"age"];
        
        // 通过person->_age不会触发KVO
        // [person willChangeValueForKey:@"age"];
        // person->_age = 10;
        // [person didChangeValueForKey:@"age"];
        
        
        // 测试setValue:forKey:的底层实现原理
        // [person setValue:@10 forKey:@"age"];
        
        
        // 模式KVC：访问成员变量的顺序key、_key、isKey、_isKey
        // person->age = 10;
        // person->_age = 11;
        // person->isAge = 12;
        // person->_isAge = 13;
        
        
        NSLog(@"%@", [person valueForKey:@"age"]);
        
        // 移除KVO监听
        [person removeObserver:observer forKeyPath:@"age"];
        
    }
    return 0;
}
