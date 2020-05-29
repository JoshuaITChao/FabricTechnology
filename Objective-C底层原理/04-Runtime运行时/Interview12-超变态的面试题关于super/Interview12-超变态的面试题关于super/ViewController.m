//
//  ViewController.m
//  Interview12-超变态的面试题关于super
//
//  Created by rz-technology on 2020/5/29.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import "ViewController.h"
#import "MCPerson.h"

@interface ViewController ()

@end

@implementation ViewController

/**
 * 1. print 为什么能调用成功？
 * 2. 为什么 self.name 变成了 ViewController 等其他内容
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // [super viewDidLoad];
    // 底层实现
    // objc_msgSendSuper({ self, [ViewController class] }, sel_registerName("viewDidLoad"))
    
    NSObject *obj2 = [[NSObject alloc] init];
//    NSString *test = @"123";
    
    id cls = [MCPerson class];
    void *obj = &cls;
    [(__bridge id)obj print];
    
    // long long p = (long long *)obj;
    // NSLog(@"%p %p", *(p+2), [ViewController class]);
    
//    struct MCPerson_IMPL
//    {
//        Class isa;
//        NSString *_name;
//    }
}


@end
