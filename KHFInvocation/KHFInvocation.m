//
//  KHFInvocation.m
//  AsyncCoreDataSample
//
//  Created by obumin on 1/4/15.
//  Copyright (c) 2015 Kawai Hiroyuki. All rights reserved.
//

#import "KHFInvocation.h"

@implementation KHFInvocation

+ (NSInvocation *)invocationWithTarget:(id)target selector:(SEL)sel object:(id)arg
{
    // get method signeture
    // 既にインスタンスされている場合はmethodSignatureForSelectorを使う
    NSMethodSignature* signature = [target methodSignatureForSelector:sel];
    // クラスメソッドとして使う場合にはinstanceMethodSignatureForSelectorを使う
    //    NSMethodSignature* signature = [[Invoker class] instanceMethodSignatureForSelector:selector];
    // make NSInvocation instance
    NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setSelector:sel];
    [invocation setTarget:target];
    [invocation setArgument:&arg atIndex:2];
    
    return invocation;
}

+ (NSInvocation *)invocationWithClass:(Class)cls selector:(SEL)sel object:(id)arg
{
    // get method signeture
    // クラスメソッドとして使う場合にはinstanceMethodSignatureForSelectorを使う
    NSMethodSignature* signature = [cls methodSignatureForSelector:sel];
    // make NSInvocation instance
    NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setSelector:sel];
    [invocation setTarget:cls];
    [invocation setArgument:&arg atIndex:2];
    
    return invocation;
}

@end
