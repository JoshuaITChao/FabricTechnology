//
//  ViewController.m
//  Interview01-GCD
//
//  Created by rz-technology on 2020/6/1.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

/**
 * dispatch_sync 和 dispatch_async 用来控制是否需要开启新的线程
 *
 * 队列类型，决定任务的执行方式（并发、串行）
 * 1、并发队列
 * 2、串行队列
 * 3、主队列（也是一个串行队列）
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 案例1
    // [self interview01];
    
    // 案例2
    // [self interview02];
    
    // 案例3
    // [self interview03];
    
    // 案例4
    // [self interview04];
    
    // 案例4
    // [self interview05];
    
    dispatch_queue_t queue1 = dispatch_get_global_queue(0, 0);
    dispatch_queue_t queue2 = dispatch_get_global_queue(0, 0);
    dispatch_queue_t queue3 = dispatch_queue_create("queu3", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue4 = dispatch_queue_create("queu4", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue5 = dispatch_queue_create("queu5", DISPATCH_QUEUE_CONCURRENT);

    NSLog(@"%p %p %p %p %p", queue1, queue2, queue3, queue4, queue5);
}

- (void)interview01
{
    // 问题：以下代码在主线程执行，会不会产生死锁？
    // 答案：会产生死锁
    // 解析：首选主队列也是一个串串行队列, dispatch_sync 不会创建子线程，而且会立即把执行任务2的 block放入主队列中，
    // 那么此时主队列中包含viewDidLoad和执行任务2的block,可是由于主队viewDidLoad在等执行任务2的block执行完毕后执行后续代码，
    // 可是执行任务2的block的在等viewDidLoad出队列才能执行，所以就产生的死锁
    NSLog(@"执行任务1");
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_sync(queue, ^{
        NSLog(@"执行任务2");
    });
    
    NSLog(@"执行任务3");
}


- (void)interview02
{
    /**
     * 问题：以下代码是在主线程中执行的，会不会产生死锁》？
     * 答案：不会
     * 执行结果：执行任务1
     *         执行任务3
     *         执行任务2
     * 解析：dispatch_async不要求立马在当前线程同步执行任务
     */
    NSLog(@"执行任务1");

    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
       NSLog(@"执行任务2");
    });

    NSLog(@"执行任务3");
}

- (void)interview03
{
    /**
     * 问题：以下代码是在主线程中执行的，会不会产生死锁？
     * 答案：会
     * 执行结果：
     *          执行任务1
     *          执行任务5
     *          执行任务2
     * 解析：
     */
    NSLog(@"执行任务1");
    dispatch_queue_t queue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"执行任务2");
        
        dispatch_sync(queue, ^{
            NSLog(@"执行任务3");
        });
        
        NSLog(@"执行任务4");
    });
    
    NSLog(@"执行任务5");
}

- (void)interview04
{
    /**
     * 问题：以下代码是在主线程中执行的，会不会产生死锁？
     * 答案：不会
     * 执行结果：
     *          执行任务1
     *          执行任务5
     *          执行任务2
     *          执行任务3
     *          执行任务4
     * 解析：
     */
    NSLog(@"执行任务1");
    dispatch_queue_t queue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue2 = dispatch_queue_create("myQueue2", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"执行任务2");
        
        dispatch_sync(queue2, ^{
            NSLog(@"执行任务3");
        });
        
        NSLog(@"执行任务4");
    });
    
    NSLog(@"执行任务5");
}

- (void)interview05
{
    /**
     * 问题：以下代码是在主线程中执行的，会不会产生死锁？
     * 答案：不会
     * 执行结果：
     *          执行任务1
     *          执行任务5
     *          执行任务2
     *          执行任务3
     *          执行任务4
     * 解析：
     */
    NSLog(@"执行任务1");
    dispatch_queue_t queue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"执行任务2");
        
        dispatch_sync(queue, ^{
            NSLog(@"执行任务3");
        });
        
        NSLog(@"执行任务4");
    });
    
    NSLog(@"执行任务5");
}

@end
