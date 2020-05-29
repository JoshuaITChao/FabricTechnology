//
//  MCPerson.m
//  Interview07-消息转发
//
//  Created by rz-technology on 2020/5/29.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import "MCPerson.h"
#import "MCCat.h"
#import <objc/runtime.h>

@implementation MCPerson

+ (id)forwardingTargetForSelector:(SEL)aSelector
{
    // objc_msgSend([[MCCat alloc] init], @selector(test))
    // [[[MCCat alloc] init] test]
    if(aSelector == @selector(test)) return [MCCat class];
    return [super forwardingTargetForSelector:aSelector];
}

//+ (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
//{
//    if (aSelector == @selector(test)) return [NSMethodSignature signatureWithObjCTypes:"v@:"];
//
//    return [super methodSignatureForSelector:aSelector];
//}
//
//+ (void)forwardInvocation:(NSInvocation *)anInvocation
//{
//    NSLog(@"1123");
//}

@end
