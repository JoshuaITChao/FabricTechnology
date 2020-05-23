# Category的底层实现原理

定义在objc-runtime-new.h中
```
struct category_t {
    const char *name;
    classref_t cls;
    struct method_lis_t *instanceMethods;
    struct method_lis_t *classMethods;
    struct protocol_list_t *protocols;
    struct property_list_t *instanceProperties;
    // Field below this point are not always present on dis
    struct peroperty_list_t *_classProperties;
    
    method_list_t *mehtodForMeta(bool isMeta) {
        if(isMeta) retur classMethods;
        else return instanceMethods;
    }
    property_list_t *propertiesForMeta(bool isMeta, struct header_info *hi);
};
```
#### Category的加载处理过程
1. 通过Runtime加载某个类的所有Category数据
2. 把所有Category的方法、属性、协议数据，合并到一个大数组中，后面参与编译的Category数据，会放在数组的前面
3. 将合并后的分类数据（方法、属性、协议），插入到类原来数据的前面

#### +load方法

+load方法时根据方法地址直接调用的，并不是经过objc_msgSend函数调用的

1. +load方法会在Runtime加载类、分类时调用
2. 每个类、分类的+load方法，在程序运行过程中只调用一次
3. 调用顺序
    * 先调用类的+load方法
        * 按照编译先后顺序调用（先编译先调用）
        * 调用子类的+load之前，会先调用父类的+load方法
    * 再调用分类的+load方法
        * 按照编译先后顺序调用（先编译先调用）    

#### +initialize方法
1. +initialize方法会在类第一次接收到消息时调用
2. 调用顺序
    * 先调用父类的+initialize，在调用子类的+initialize
    * 先出初始化父类，再初始化子类，每个类只会初始化1次
3. +initialize和+load的最大区别是：
    * +initialize时通过objc_msgSend进行调用的，所以具有以下特点
        * 如果子类没有实现+initialize，会调用父类的+initialize（所以父类的+initialize可能会被调用的多次）
        * 如果分类实现了+initialize，就会覆盖本身的+initialize调用 
        
#### 总结
1、**+load和+initialize方法的区别是什么？**

* 调用方式
    * +load是根据函数地址直接调用的
    * +initialize是通过objc_msgSend调用的
* 调用时机
    * +load是通过Runtime在加载类、分类的时候调用的（只会调用一次）
    * +initialize是类第一次收到消息的时候调用的，每一个类只会+initialize一次（父类的initialize方法可能会被调用多次）

2、**+load和+initialize方法的调用顺序？**
 
 * +load
     * 先调用类的+load方法
         * 先编译的类，优先调用+load方法
         * 调用子类的+load之前，会先调用父类的+load方法 
     * 调用分类的+load
         * 下编译的分类，优先调用+load  
 * +initialize
     * 先初始化父类
     * 在初始化子类（可能最终调用的是父类的+initialize方法） 