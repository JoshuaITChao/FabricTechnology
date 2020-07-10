//
//  ViewController.m
//  Interview01-定时器
//
//  Created by rz-technology on 2020/7/8.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import "ViewController.h"
#import "MCProxy1.h"

@interface ViewController ()
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     * 会产生循环引用，导致内存泄漏
     */
    //self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTest) userInfo:nil repeats:YES];
    
    // 解决办法
    // 1.block
//    __weak typeof(self) weakSelf = self;
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f repeats:YES block:^(NSTimer * _Nonnull timer) {
//        [weakSelf timerTest];
//    }];
    
    // 2.代理对象（proxy）
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:[MCProxy1 proxyWithTarget:self] selector:@selector(timerTest) userInfo:nil repeats:YES];
    
}

- (void)timerTest
{
    NSLog(@"%s",__func__);
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
    [self.timer invalidate];
}


@end
