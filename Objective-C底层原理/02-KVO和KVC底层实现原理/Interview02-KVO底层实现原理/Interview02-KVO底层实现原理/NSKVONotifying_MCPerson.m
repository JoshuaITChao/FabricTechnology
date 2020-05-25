//
//  NSKVONotifying_MCPerson.m
//  Interview02-KVO底层实现原理
//
//  Created by rz-technology on 2020/5/25.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import "NSKVONotifying_MCPerson.h"

@implementation NSKVONotifying_MCPerson


/// 重写setAge方法
- (void)setAge:(int)age
{
    // 内部调用_NSSetIntValueAndNotify();
    _NSSetIntValueAndNotify();
}


/// 屏蔽内部实现，隐藏了NSKVONotifying_MCPerson类的存在
- (Class)class
{
    return [MCPerson class];
}


/// 为代码
void _NSSetIntValueAndNotify()
{
    [self willChangeValueForKey:@"age"];
    [super setAge: age];
    [self didChangeValueForKey:@"age"];
}

- (void)didChangeValueForKey:(NSString *)key
{
    // 通知监听器，某个属性值发生了改变
    [oberser observeValueForKeyPath:key ofObject:self change:nil context:nil];
}

- (BOOL)_isKVOA
{
    return YES;
}

@end
