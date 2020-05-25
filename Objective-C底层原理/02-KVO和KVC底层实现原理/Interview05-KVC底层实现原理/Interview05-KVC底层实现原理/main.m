//
//  main.m
//  Interview05-KVC底层实现原理
//
//  Created by rz-technology on 2020/5/25.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCPerson.h"
#import "MCObserver.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        MCObserver *observer = [[MCObserver alloc] init];
        MCPerson *person = [[MCPerson alloc] init];
        
        // 添加KVO监听
        [person addObserver:observer forKeyPath:@"age" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
        
        // 通过KVC修改age属性
        [person setValue:@10 forKey:@"age"];
        
        // setAge:
        // 移除KVO监听
        [person removeObserver:observer forKeyPath:@"age"];
        
        // person.age = 10;
        
        // NSLog(@"%@",[person valueForKey:@"age"]);
        // NSLog(@"%@",[person valueForKeyPath:@"cat.weight"]);
        
        person.cat = [[MCCat alloc] init];
        [person setValue:@10 forKeyPath:@"cat.weight"];
        
        
         NSLog(@"%@",[person valueForKey:@"age"]);
         NSLog(@"%@",[person valueForKeyPath:@"cat.weight"]);
        
    }
    return 0;
}
