//
//  MCProxy.h
//  Interview01-定时器
//
//  Created by rz-technology on 2020/7/8.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCProxy : NSProxy

@property (weak, nonatomic) id target;
+ (instancetype)proxyWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
