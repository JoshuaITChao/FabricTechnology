//
//  MCPerson.m
//  Interview06-消息转发
//
//  Created by rz-technology on 2020/5/29.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import "MCPerson.h"
#import "MCCat.h"
#import <objc/runtime.h>

@implementation MCPerson

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    if(aSelector == @selector(test:)){
        // return [NSMethodSignature signatureWithObjCTypes:"v20@0:8i16"];
        return [NSMethodSignature signatureWithObjCTypes:"i@:i"];
        // return [[[MCCat alloc] init] methodSignatureForSelector:aSelector];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    // 参数顺序：receiver、seletor、other arguments
    // int age;
    // [anInvocation getArgument:&age atIndex:2];
    // NSLog(@"%d", age + 10);
    
    //anInvocation.target = [[MCCat alloc] init];
    //anInvocation.selector = @selector(test:);
    // anInvocation的参数：15
    // [[[MCCat alloc] init] test:15];
    
    [anInvocation invokeWithTarget:[[MCCat alloc] init]];
    int ret;
    [anInvocation getReturnValue:&ret];
    NSLog(@"ret = %d", ret);
}
@end
