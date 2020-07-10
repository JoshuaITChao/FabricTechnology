//
//  ViewController.m
//  Interview02-GCD定时器
//
//  Created by rz-technology on 2020/7/8.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import "ViewController.h"
#import "MCTimer.h"

@interface ViewController ()
@property (strong, nonatomic) dispatch_source_t timer;
@property (copy, nonatomic)   NSString *task;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"begin");
    
    // 接口设计
    self.task = [MCTimer execTask:self selector:@selector(doTask) start:0.0f interval:1.0f repeats:YES async:NO];
    
}

- (void)doTask
{
    NSLog(@"doTask - %@", [NSThread currentThread]);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [MCTimer cancelTask:self.task];
}


- (void)gcdTimerTest
{
    // 创建队列
     dispatch_queue_t queue = dispatch_get_main_queue();
     
     // 创建定时器
     dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
     
     // 设置时间
     uint64_t start = 0.0;     // 2秒后执行
     uint64_t interval = 1.0;  // 每隔1秒执行
     dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, start * NSEC_PER_SEC, interval * NSEC_PER_SEC);
    
     // 设置回调
     dispatch_source_set_event_handler(timer, ^{
         NSLog(@"-----11111-----");
     });
     dispatch_resume(timer);
     
     self.timer = timer;
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
    
    self.timer = nil;
}

@end
