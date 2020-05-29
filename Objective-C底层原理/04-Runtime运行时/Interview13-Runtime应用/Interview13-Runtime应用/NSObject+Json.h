//
//  NSObject+Json.h
//  Interview13-Runtime应用
//
//  Created by rz-technology on 2020/5/29.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Json)

+ (instancetype)mc_objectWithJson:(NSDictionary *)json;

@end

NS_ASSUME_NONNULL_END
