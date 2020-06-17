//
//  ViewController.m
//  Interview02-线程保活
//
//  Created by rz-technology on 2020/6/17.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import "ViewController.h"
#import "MCThread.h"

@interface ViewController ()
@property (strong, nonatomic) MCThread *thread;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.thread = [[MCThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    [self.thread start];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self performSelector:@selector(test) onThread:self.thread withObject:nil waitUntilDone:NO];
}


// 子线程需要执行的任务
- (void)test
{
    NSLog(@"%s %@", __func__, [NSThread currentThread]);
}


/// 这个方法的目的：线程保活
- (void)run
{
    NSLog(@"%s %@", __func__, [NSThread currentThread]);
    
    // 往RunLoop里面添加Source/Timer/Observer
    [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] run];
    
    NSLog(@"%s -----end-----",__func__);
}


@end
