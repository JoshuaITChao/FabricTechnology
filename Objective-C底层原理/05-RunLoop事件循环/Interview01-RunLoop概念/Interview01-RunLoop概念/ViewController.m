//
//  ViewController.m
//  Interview01-RunLoop概念
//
//  Created by rz-technology on 2020/6/1.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

NSMutableDictionary *runloops;

void observerRunLoopActivities(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info)
{
    switch (activity) {
        case kCFRunLoopEntry:
            NSLog(@"kCFRunLoopEntry");
            break;
        case kCFRunLoopBeforeTimers:
            NSLog(@"kCFRunLoopBeforeTimers");
            break;
        case kCFRunLoopBeforeSources:
            NSLog(@"kCFRunLoopBeforeSources");
            break;
        case kCFRunLoopBeforeWaiting:
            NSLog(@"kCFRunLoopBeforeWaiting");
            break;
        case kCFRunLoopAfterWaiting:
            NSLog(@"kCFRunLoopAfterWaiting");
            break;
        case kCFRunLoopExit:
            NSLog(@"kCFRunLoopExit");
            break;
        default:
            break;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.RunLoop分两种实现:
    // OC对象      NSRunLoop
    // C语言对象    CFRunLoopRef
    // NSRunLoop *runloop;
    // CFRunLoopRef runloop2;
    
    // 2.RunLoop是如何实现不同线程的不同循环呢？
    // 底层实现是通过 类似以线程作为 key ，事件循环作为 value
    // runloops[thread] = runloop
    
    // 3.获取当前循环的两种方法
    // NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    // CFRunLoopRef runloop2 = CFRunLoopGetCurrent();
    
    // OC -> CoreFoundation的对应关系
    // NSArray *array;
    // CFArrayRef array2;
    
    // NSString *string;
    // CFStringRef string2
    
     // NSLog(@"%p %p", [NSRunLoop currentRunLoop], [NSRunLoop mainRunLoop]);
     // NSLog(@"%p %p", CFRunLoopGetCurrent(), CFRunLoopGetMain());
    
    // 4.有序的
    // NSMutableArray *array;
    // [array addObject:@"1"];
    // array[0];
    
    // 无序的
    // NSMutableSet *set;
    // [set addObject:@"1"];
    // [set anyObject];
    
    // 5.事件循环模式相关用法
    // kCFRunLoopDefaultMode
    // NSDefaultRunLoopMode
    //NSLog(@"%@", [NSRunLoop mainRunLoop]);
    
    
    self.view.backgroundColor = [UIColor redColor];
    
    // kCFRunLoopCommonModes默认包括 kCFRunLoopDefaultMode和UITrackingRunLoopMode
    
    // 创建Observer
    // CFRunLoopObserverRef observer = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, observerRunLoopActivities, NULL);
    // 添加Observer到RunLoop中
    // CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopCommonModes);
    // 释放
    // CFRelease(observer);
    
    // 创建Observer
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        switch (activity) {
            case kCFRunLoopEntry:
            {
                CFRunLoopMode mode = CFRunLoopCopyCurrentMode(CFRunLoopGetCurrent());
                NSLog(@"kCFRunLoopEntry - %@", mode);
                CFRelease(mode);
                break;
            }
            case kCFRunLoopExit: {
                CFRunLoopMode mode = CFRunLoopCopyCurrentMode(CFRunLoopGetCurrent());
                NSLog(@"kCFRunLoopExit - %@", mode);
                CFRelease(mode);
                break;
            }
                
            default:
                break;
        }
    });
    // 添加Observer到RunLoop中
    CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopCommonModes);
    // 释放
    CFRelease(observer);
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [NSTimer scheduledTimerWithTimeInterval:3.0 repeats:NO block:^(NSTimer * _Nonnull timer) {
        NSLog(@"定时器----------");
    }];
}


@end
    
