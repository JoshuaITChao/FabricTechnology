//
//  MCStudent.m
//  Interview12-超变态的面试题关于super
//
//  Created by rz-technology on 2020/5/29.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import "MCStudent.h"

@implementation MCStudent

- (void)print
{
    [super print];
    
//    objc_msgSendSuper(
//    {
//        self,
//        [MCPerson class]
//    },sel_registerName("print"));
    
//    int a = 10;
}

@end
