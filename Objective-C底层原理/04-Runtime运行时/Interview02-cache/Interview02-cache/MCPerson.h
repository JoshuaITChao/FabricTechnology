//
//  MCPerson.h
//  Interview02-cache
//
//  Created by rz-technology on 2020/5/26.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCPerson : NSObject

- (void)personTest;

// _key = @selector(personTest)
// _imp = personTest的函数地址

@end

NS_ASSUME_NONNULL_END
