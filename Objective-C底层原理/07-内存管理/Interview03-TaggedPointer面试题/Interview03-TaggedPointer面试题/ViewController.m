//
//  ViewController.m
//  Interview03-TaggedPointer面试题
//
//  Created by rz-technology on 2020/7/8.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (copy, nonatomic) NSString *name;
@end

@implementation ViewController


//- (void)setName:(NSString *)name
//{
//    if(_name != name){
//        [_name release];
//        _name = [name retain];
//    }
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    // 第一道面试题
    // 导致崩溃：崩溃的主要原因是由于异步，导致我们在setName的时候，对 _name 进行了 release 操作，由于同时操作，可能导致已经 release 的对象，再次 release 就会出现闪退
//    for (int i = 0; i < 100; i++) {
//        dispatch_async(queue, ^{
//
//            // 解决办法：
//            // 加锁
//            self.name = [NSString stringWithFormat:@"abcdefghijk"];
//            // 解锁
//        });
//    }
    
    
    // 第二道面试题
    // 不会出现闪退，是因为Tagged Pointer对小对象进行了优化
    for (int i = 0; i < 100; i++) {
        dispatch_async(queue, ^{
            self.name = [NSString stringWithFormat:@"abc"];
        });
    }
    
}


@end
