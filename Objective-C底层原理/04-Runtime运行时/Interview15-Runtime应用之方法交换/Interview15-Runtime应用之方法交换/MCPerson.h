//
//  MCPerson.h
//  Interview15-Runtime应用之方法交换
//
//  Created by rz-technology on 2020/5/29.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCPerson : NSObject<NSCoding>
{
    int _sex;
}
@property (assign, nonatomic) int ID;
@property (assign, nonatomic) int weight;
@property (assign, nonatomic) int age;
@property (copy, nonatomic) NSString *name;

- (void)run;

- (void)test;

@end

NS_ASSUME_NONNULL_END
