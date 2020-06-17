//
//  MCPermenantThread.h
//  Interview04-线程保活封装
//
//  Created by rz-technology on 2020/6/17.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^MCPermenantThreadTask)(void);

@interface MCPermenantThread : NSObject


/// 在当前子线程执行一个任务
- (void)executeTask:(MCPermenantThreadTask)task;


/// 结束线程
- (void)stop;

@end

NS_ASSUME_NONNULL_END
