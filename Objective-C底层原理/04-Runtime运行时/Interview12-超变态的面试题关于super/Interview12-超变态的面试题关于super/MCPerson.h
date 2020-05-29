//
//  MCPerson.h
//  Interview12-超变态的面试题关于super
//
//  Created by rz-technology on 2020/5/29.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCPerson : NSObject
@property (copy, nonatomic)   NSString *name;

- (void)print;
@end

NS_ASSUME_NONNULL_END
