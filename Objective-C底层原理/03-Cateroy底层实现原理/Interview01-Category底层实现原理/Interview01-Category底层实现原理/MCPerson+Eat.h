//
//  MCPerson+Eat.h
//  
//  Interview01-Category底层实现原理
//  Created by rz-technology on 2020/5/22.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import "MCPerson.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCPerson (Eat)<NSCopying, NSCoding>

- (void)eat;

@property (assign, nonatomic) int weight;
@property (assign, nonatomic) double height;

@end

NS_ASSUME_NONNULL_END
