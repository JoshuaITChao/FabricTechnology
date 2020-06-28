//
//  ViewController.m
//  Interview04-线程保活封装
//
//  Created by rz-technology on 2020/6/17.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import "ViewController.h"
#import "MCPermenantThread.h"
@interface ViewController ()
@property (strong, nonatomic) MCPermenantThread *thread;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.thread = [[MCPermenantThread alloc] init];
 
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.thread executeTask:^{
        NSLog(@"执行任务----- %@",[NSThread currentThread]);
    }];
}

- (IBAction)stopBtnClick:(UIButton *)sender {
    [self.thread stop];
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

@end
