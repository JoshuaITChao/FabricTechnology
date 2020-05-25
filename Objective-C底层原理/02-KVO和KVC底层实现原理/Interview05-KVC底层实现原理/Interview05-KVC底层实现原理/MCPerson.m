//
//  MCPerson.m
//  Interview05-KVC底层实现原理
//
//  Created by rz-technology on 2020/5/25.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import "MCPerson.h"

@implementation MCPerson

/**
 * KVO优先按照setKey:和_setKey：的顺序查找
 */
//- (void)setAge:(int)age
//{
//    _age = age;
//    NSLog(@"setAge: %d", age);
//}

//- (void)_setAge:(int)age
//{
//    NSLog(@"_setAge: %d",age);
//}

/**
 * KVC优先查找顺序：getKey、Key、isKey、_key、
 */
//- (int)getAge
//{
//    return 10;
//}
//- (int)age
//{
//    return 11;
//}
//- (int)isAge
//{
//    return 12;
//}
//- (int)_age
//{
//    return 13;
//}

- (void)willChangeValueForKey:(NSString *)key
{
    [super willChangeValueForKey:key];
    NSLog(@"willChangeValueForKey -%@",key);
}

- (void)didChangeValueForKey:(NSString *)key
{
    NSLog(@"didChangeValueForKey -beigin-%@", key);
    [super didChangeValueForKey:key];
    NSLog(@"didChangeValueForKey -end-%@",key);
}


/// 是否允许直接访问成员变量，默认是YES
+ (BOOL)accessInstanceVariablesDirectly
{
    return YES;
}

@end
