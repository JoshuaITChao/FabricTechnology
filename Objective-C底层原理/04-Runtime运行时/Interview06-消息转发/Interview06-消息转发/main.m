//
//  main.m
//  Interview06-消息转发
//
//  Created by rz-technology on 2020/5/29.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCPerson.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        MCPerson *person = [[MCPerson alloc] init];
        [person test:15];

    }
    return 0;
}
