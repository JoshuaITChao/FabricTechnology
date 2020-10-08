//
//  main.m
//  Interview15-Runtime应用之方法交换
//
//  Created by rz-technology on 2020/5/29.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCPerson.h"
#import <objc/runtime.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
//        MCPerson *person = [[MCPerson alloc] init];
//
//        Method runMethod = class_getInstanceMethod([MCPerson class], @selector(run));
//        Method testMethod = class_getInstanceMethod([MCPerson class], @selector(test));
//
//        method_exchangeImplementations(runMethod, testMethod);
//
//        [person run];
//
//        [person test];
        
        unsigned int propertyCount;
        unsigned int ivarCount;
        objc_property_t *propertyList = class_copyPropertyList([MCPerson class], &propertyCount);
        Ivar *ivarList = class_copyIvarList([MCPerson class], &ivarCount);
        for (int i=0; i<propertyCount; i++) {
            objc_property_t thirdProperty = propertyList[i];
            const char *propertyCName = property_getName(thirdProperty);
            NSString *propertyName = [NSString stringWithCString:propertyCName encoding:NSUTF8StringEncoding];
            NSLog(@"propertyName------%@",propertyName);
        }
        
        for (int i=0; i<ivarCount; i++) {
            Ivar ivar = ivarList[i];
            const char *ivarCName = ivar_getName(ivar);
            NSString *ivarName = [NSString stringWithCString:ivarCName encoding:NSUTF8StringEncoding];
            NSLog(@"ivarName--------%@",ivarName);
        }
        
    }
    return 0;
}
