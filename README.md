# AssociatedObjectDemo
A sample project of Associated Object in Objective-C
# 关联对象 Associated Objects

iOS中我们日常使用的最频繁的应该算是`@property`里，这是一个集

* 实例变量的声明
* getter
* setter

三者合一的具有`元编程`思想的集合，但是当我们使用`Category`的时候，想在里面增加一个'@property'的时候，我们会得到编译器给的警告:

```swift
Property 'categoryProperty' requires method 'categoryProperty' to be defined - use @dynamic or provide a method implementation in this category
```

这说明在`Category`里苹果并不会帮我们去生成`getter`和`setter`方法。这个时候，`关联对象`就派上了用处了。

```swift

#import <objc/runtime.h>
----

- (NSString *)categoryProperty
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setCategoryProperty:(NSString *)categoryProperty
{
    objc_setAssociatedObject(self, @selector(categoryProperty), categoryProperty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
```

上面的两个方法分别实现了`getter`与`setter`，同时引入了` <objc/runtime.h>`这个Runtime头文件，我们的目的很简单，下面来简单看下这两个方法。

```swift
id objc_getAssociatedObject(id object, const void *key);
```

> Returns the value associated with a given object for a given key.

这个方法返回了一个给定key和给定对象的关联对象，我们这里使用了`_cmd`来作为当前方法的选择子，也就是`@selector(categoryProperty)`。

```swift
void objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy);
```

> Sets an associated value for a given object using a given key and association policy.

这个方法会根据给定的对象，给定的key以及关联策略来设置一个关联对象的值。
我们来看下关于`objc_AssociationPolicy`的定义

```swift
typedef OBJC_ENUM(uintptr_t, objc_AssociationPolicy) {
    OBJC_ASSOCIATION_ASSIGN = 0,           /**< Specifies a weak reference to the associated object. */
    OBJC_ASSOCIATION_RETAIN_NONATOMIC = 1, /**< Specifies a strong reference to the associated object. 
                                            *   The association is not made atomically. */
    OBJC_ASSOCIATION_COPY_NONATOMIC = 3,   /**< Specifies that the associated object is copied. 
                                            *   The association is not made atomically. */
    OBJC_ASSOCIATION_RETAIN = 01401,       /**< Specifies a strong reference to the associated object.
                                            *   The association is made atomically. */
    OBJC_ASSOCIATION_COPY = 01403          /**< Specifies that the associated object is copied.
                                            *   The association is made atomically. */
};
```

很清晰明了，不同的`objc_AssociationPolicy`对应了不同的属性修饰符。


-------


本文部分内容引用自[Draveness的文章-关联对象 AssociatedObject 完全解析](https://github.com/Draveness/analyze/blob/master/contents/objc/%E5%85%B3%E8%81%94%E5%AF%B9%E8%B1%A1%20AssociatedObject%20%E5%AE%8C%E5%85%A8%E8%A7%A3%E6%9E%90.md)，感谢原作者的无私分享!

