//
//  MCPermenantThread.m
//  Interview04-线程保活封装
//
//  Created by rz-technology on 2020/6/17.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import "MCPermenantThread.h"


@interface MCThread : NSThread

@end

@implementation MCThread

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

@end


@interface MCPermenantThread()
@property (strong, nonatomic) MCThread *innerThread;
@end


@implementation MCPermenantThread

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        __weak typeof(self) weakSelf = self;
        self.innerThread = [[MCThread alloc] initWithBlock:^{
            NSLog(@"-----begin-----");
            // 创建上下文（要初始化一下结构体）
            CFRunLoopSourceContext context = {0};

            // 创建source
            CFRunLoopSourceRef source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);

            // 往Runloop中添加source
            CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);

            // 销毁source
            CFRelease(source);

            // 启动
            CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0e10, false);

            //            while (weakSelf && !weakSelf.isStopped) {
            //                // 第3个参数：returnAfterSourceHandled，设置为true，代表执行完source后就会退出当前loop
            //                CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0e10, true);
            //            }

            NSLog(@"end----");
        }];
        
        [self.innerThread start];
        
    }
    return self;
}

/// 在当前子线程执行一个任务
- (void)executeTask:(MCPermenantThreadTask)task
{
    if(!self.innerThread || !task) return;
    
    [self performSelector:@selector(__executeTask:) onThread:self.innerThread withObject:task waitUntilDone:NO];
}


/// 结束线程
- (void)stop
{
    if(!self.innerThread) return;
    
    [self performSelector:@selector(__stopThread) onThread:self.innerThread withObject:nil waitUntilDone:YES];
}

#pragma mark - 私有方法
- (void)__executeTask:(MCPermenantThreadTask)task
{
    task();
}

- (void)__stopThread
{    
    // 终止RunLoop
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.innerThread = nil;
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
    
    [self stop];
}

@end
