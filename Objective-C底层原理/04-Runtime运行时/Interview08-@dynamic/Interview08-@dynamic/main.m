//
//  main.m
//  Interview08-@dynamic
//
//  Created by rz-technology on 2020/5/29.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCPerson.h"


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        MCPerson *person = [[MCPerson alloc] init];
        person.age = 20;
        
        NSLog(@"%d",person.age);
        
    }
    return 0;
}
