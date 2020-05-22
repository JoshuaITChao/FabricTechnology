//
//  main.m
//
//
//  Created by rz-technology on 2020/5/22.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCPerson.h"
#import "MCPerson+Eat.h"
#import "MCPerson+Test.h"
#import <objc/runtime.h>

//// 定义在objc-runtime-new.h中
//struct category_t {
//    const char *name;
//    classref_t cls;
//    struct method_lis_t *instanceMethods;
//    struct method_lis_t *classMethods;
//    struct protocol_list_t *protocols;
//    struct property_list_t *instanceProperties;
//    // Field below this point are not always present on dis
//    struct peroperty_list_t *_classProperties;
//    
//    method_list_t *mehtodForMeta(bool isMeta) {
//        if(isMeta) retur classMethods;
//        else return instanceMethods;
//    }
//    property_list_t *propertiesForMeta(bool isMeta, struct header_info *hi);
//};

// 工具类打印方法列表
void printMethodNamesOfClass(Class cls)
{
    unsigned int count;
    // 获得方法数组
    Method *methodList = class_copyMethodList(cls, &count);
    
    // 存储方法名
    NSMutableString *methodNames = [NSMutableString string];
    
    // 遍历所有的方法
    for (int i = 0; i < count; i++) {
        // 获得方法
        Method method = methodList[i];
        // 获得方法名
        NSString *methodName = NSStringFromSelector(method_getName(method));
        // 拼接方法名
        [methodNames appendString:methodName];
        [methodNames appendString:@", "];
    }
    
    // 释放
    free(methodList);
    
    // 打印方法名
    NSLog(@"%@ %@", cls, methodNames);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        MCPerson *person = [[MCPerson alloc] init];
        [person run];
        
        printMethodNamesOfClass(object_getClass([MCPerson class]));
        
//        objc_msgSend(person, @selector(run));
//        [person test];
//        [person eat];
//        objc_msgSend(person, @selector(eat));
        
        // 通过runtime动态的将分类的方法合并到对象中、原类对象中
    }
    return 0;
}
