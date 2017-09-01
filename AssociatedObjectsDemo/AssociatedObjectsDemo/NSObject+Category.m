//
//  NSObject+Category.m
//  AssociatedObjectsDemo
//
//  Created by leejunhui on 2017/9/1.
//  Copyright © 2017年 leejunhui. All rights reserved.
//

#import "NSObject+Category.h"
#import <objc/runtime.h>
@implementation NSObject (Category)

- (NSString *)categoryProperty
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setCategoryProperty:(NSString *)categoryProperty
{
    objc_setAssociatedObject(self, @selector(categoryProperty), categoryProperty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
