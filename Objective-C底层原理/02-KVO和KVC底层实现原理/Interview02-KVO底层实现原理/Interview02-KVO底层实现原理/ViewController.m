//
//  ViewController.m
//  Interview02-KVO底层实现原理
//
//  Created by rz-technology on 2020/5/25.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import "ViewController.h"
#import "MCPerson.h"
#import <objc/runtime.h>

@interface ViewController ()
@property (strong, nonatomic) MCPerson *person1;
@property (strong, nonatomic) MCPerson *person2;
@end

@implementation ViewController


- (void)printMethodNamesOfClass:(Class)cls
{
    unsigned int count;
    // 获得方法数组
    Method *methodList = class_copyMethodList(cls, &count);
    
    // 存储方法名
    NSMutableString *methodNames = [NSMutableString string];
    
    // 遍历所有的方法
    for (int i = 0; i < count; i++) {
        // 获得方法
        Method method = methodList[i];
        // 获得方法名
        NSString *methodName = NSStringFromSelector(method_getName(method));
        // 拼接方法名
        [methodNames appendString:methodName];
        [methodNames appendString:@", "];
    }
    
    // 释放
    free(methodList);
    
    // 打印方法名
    NSLog(@"%@ %@", cls, methodNames);
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.person1 = [[MCPerson alloc] init];
    self.person1.age = 1;
    
    self.person2 = [[MCPerson alloc] init];
    self.person2.age = 2;
    
    // 给person1对象添加KVO监听
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.person1 addObserver:self forKeyPath:@"age" options:options context:@"123"];
    
    [self printMethodNamesOfClass:object_getClass(self.person1)];
    [self printMethodNamesOfClass:object_getClass(self.person2)];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // NSKVONotifying_MCPerson是使用Runtime动态创建的一个类，是MCPerson的子类NSKVONotifying_MCPerson
    
    // self.person1.isa == NSKVONotifying_MCPerson
    [self.person1 setAge:21];
    
    // self.person2.isa == MCPerson;
    [self.person2 setAge:22];
    
}

- (void)dealloc
{
    [self.person1 removeObserver:self forKeyPath:@"age"];
}


/// 当监听对象的属性值发生改变的时候，就会调用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"监听到 %@ 的 %@ 属性发生改变了 - %@ - %@",object, keyPath, change, context);
}


@end
