//
//  main.m
//  Interview03-objc_msgSend
//
//  Created by rz-technology on 2020/5/28.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCGoodStudent.h"
#import "MJClassInfo.h"
#import <objc/runtime.h>

// receiver: 消息接收者
// selector: 消息名称
void objc_msgSend(id receiver, SEL selector)
{
    if(receiver == nil) return;
    
    // 查找缓存
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        MCGoodStudent *gs = [[MCGoodStudent alloc] init];
        [gs goodStudentTest];
        
        MCPerson *person = [[MCPerson alloc] init];
        [person personTest];
        
        // 底层调用
        // objc_msgSend(person, @selector(personTest));
        // 消息接收者(receiver)：person
        // 消息名称：personTest
        
        [MCPerson initialize];
        // 底层调用实现
        // objc_msgSend([MCPerson class], @selector(initialize));
        // 消息接收者（receiver）：[MCPerson class]
        // 消息名称：initialize
        
        // OC的方法调用：消息机制，给方法的调用者发送消息
        
        // objc_msgSend如果找不到合适的方法进行调用，会报错 unrecognized selector sent to instance
    }
    return 0;
}
