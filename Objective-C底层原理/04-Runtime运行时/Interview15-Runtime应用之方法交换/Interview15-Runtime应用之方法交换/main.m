//
//  main.m
//  Interview15-Runtime应用之方法交换
//
//  Created by rz-technology on 2020/5/29.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCPerson.h"
#import <objc/runtime.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        MCPerson *person = [[MCPerson alloc] init];
        
        Method runMethod = class_getInstanceMethod([MCPerson class], @selector(run));
        Method testMethod = class_getInstanceMethod([MCPerson class], @selector(test));
        
        method_exchangeImplementations(runMethod, testMethod);
        
        [person run];
        
        [person test];
        
    }
    return 0;
}
