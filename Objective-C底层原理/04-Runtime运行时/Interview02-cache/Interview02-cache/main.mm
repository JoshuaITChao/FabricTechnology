//
//  main.m
//  Interview02-cache
//
//  Created by rz-technology on 2020/5/26.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCGoodStudent.h"
#import "MJClassInfo.h"

// class结构
//struct objc_class {
//    Class isa;
//    Class superclass;
//    cache_t cache;  // 方法缓存
//    class_data_bits_t bits; // 经过 & FAST_DATA_MASK 会得到具体的类信息,即 class_rw_t
//}

/**
 * 在程序编译阶段，先将类的相关信息(属性、方法)存放在 class_ro_t 中，在运行的时候，会将该类的相关分类中的信息（属性、方法）进行合并
 * 并统一存放到 class_rw_t 中
 */

//
//struct class_rw_t {
//    uint32_t flags;
//    uint32_t vesion;
//    const class_ro_t *ro;
//    method_array_list *methods;             // 方法列表（二维数据，数组里存放 method_list 类型的一维数组， method_list 里面存放 method_t 类型的数据）
//    property_list_t *properties;            // 属性列表,同上
//    const protocol_array_list_t protocols;  // 协议列表
//    // ...
//}
//
//struct class_ro_t {
//    method_list_t *baseMethodList;     // 方法列表,里面存放 method_t
//    property_list_t *basePropertyList; // 属性列表
//    // ...
//}
//
//struct method_t {
//    SEL *name;  // 函数名
//    const char *types;  // 编码（返回值类型、参数类型）
//    IMP imp;    // 指向函数的指针（函数地址）
//}
//
//
//
// isa内存的cache_t
//struct cache_t
//{
//    struct bucket_t *buckets; // 散列表（哈希表）
//    mask_t _mask; // 散列表的长度 - 1
//    mask_t _occupied; // 已经缓存的方法都数量
//}

// buckets 中存放 bucket_t
//struct bucket_t {
//    cache_key_t _key;   // 散列表的key    key的计算规则 @selector(sel) & _mask 计算出索引，如果没有找到，难么就会进行 -1 操作继续进行查找
//    IMP _imp;           // 函数的内存地址
//}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
   
        // MCPerson *person = [[MCPerson alloc] init];
        // mj_objc_class *personClass = (__bridge mj_objc_class *)[MCPerson class];
        
        // [person personTest];
        
        // 获取selector的方法
        // 1.@seletor("name");
        // 2.sel_registerName("name");
        
        MCGoodStudent *goodStudent = [[MCGoodStudent alloc] init];
        mj_objc_class *goodStudentClass = (__bridge mj_objc_class *)[MCGoodStudent class];
        
        [goodStudent goodstudentTest];
        [goodStudent studentTest];
        [goodStudent personTest];
        [goodStudent goodstudentTest];
        [goodStudent studentTest];
        
        NSLog(@"----------------");
    
        cache_t cache = goodStudentClass->cache;
        NSLog(@"%s %p", @selector(personTest), cache.imp(@selector(personTest)));
        NSLog(@"%s %p", @selector(studentTest), cache.imp(@selector(studentTest)));
        NSLog(@"%s %p", @selector(goodstudentTest), cache.imp(@selector(goodstudentTest)));
        
        bucket_t *buckets = cache._buckets;
        bucket_t bucket = buckets[(long long)@selector(studentTest) & cache._mask];
        NSLog(@"%s %p", bucket._key, bucket._imp);
        
        
        for (int i=0; i<=cache._mask; i++) {
            bucket_t bucket = buckets[i];
            NSLog(@"%s %p", bucket._key, bucket._imp);
        }
        
    }
    return 0;
}
