//
//  ViewController.m
//  Interview03-线程保活优化
//
//  Created by rz-technology on 2020/6/17.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import "ViewController.h"
#import "MCThread.h"

@interface ViewController ()
@property (strong, nonatomic) MCThread *thread;
@property (assign, nonatomic, getter=isStopped) BOOL stopped;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     * NSRunLoop的run方法是无法停止的，它专门用于开启一个永不销毁的线程（NSRunLoop）
     * [[NSRunLoop currentRunLoop] run];
     */
    __weak typeof(self) weakSelf = self;
    self.stopped = NO;
    self.thread = [[MCThread alloc] initWithBlock:^{
        NSLog(@"%@-----begin------",[NSThread currentThread]);
       
        // 往RunLoop里面添加Source/Timer/Observer
        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
        while (!weakSelf.isStopped) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
        
       
        NSLog(@"%@-----end------",[NSThread currentThread]);
    }];
    [self.thread start];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if(!self.thread) return;
    [self performSelector:@selector(test) onThread:self.thread withObject:nil waitUntilDone:NO];
}

// 子线程需要执行的任务
- (void)test
{
    NSLog(@"%s %@", __func__, [NSThread currentThread]);
}
- (IBAction)stopBtnClick:(UIButton *)sender {
    
    if(!self.thread) return;
    [self performSelector:@selector(stopThread) onThread:self.thread withObject:nil waitUntilDone:NO];
}


// 用于停止子线程的RunLoop
- (void)stopThread
{
    // 设置标记
    self.stopped = YES;

    // 停止RunLoop
    CFRunLoopStop(CFRunLoopGetCurrent());
    NSLog(@"%s %@", __func__, [NSThread currentThread]);
    
    // 清空线程
    self.thread = nil;
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
    
    [self stopBtnClick:nil];
}

@end
