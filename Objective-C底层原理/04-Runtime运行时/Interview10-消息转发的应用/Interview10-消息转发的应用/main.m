//
//  main.m
//  Interview10-消息转发的应用
//
//  Created by rz-technology on 2020/5/29.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCPerson.h"

// 降低unrecognized selector崩溃率
int main(int argc, const char * argv[]) {
    @autoreleasepool {

        MCPerson *person = [[MCPerson alloc] init];
        [person run];
        [person test];
        [person other];
        
    }
    return 0;
}
