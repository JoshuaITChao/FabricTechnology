//
//  MCPerson.h
//  Interview13-Runtime应用
//
//  Created by rz-technology on 2020/5/29.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCPerson : NSObject

@property (nonatomic, assign) int ID;
@property (nonatomic, assign) int weight;
@property (nonatomic, assign) int age;
@property (nonatomic, copy)   NSString *name;

- (void)run;

@end

NS_ASSUME_NONNULL_END
