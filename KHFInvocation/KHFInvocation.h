//
//  KHFInvocation.h
//  AsyncCoreDataSample
//
//  Created by obumin on 1/4/15.
//  Copyright (c) 2015 Kawai Hiroyuki. All rights reserved.
//
//
//  (Example)
//    NSInvocation* invocation = [KHFInvocation invocationWithClass:[Invoker class]
//                                                         selector:@selector(showText:)
//                                                           object:@"Hello"];
//
//    NSInvocationOperation *io = [[NSInvocationOperation alloc] initWithInvocation:invocation];
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    [queue addOperation:io];
//

#import <Foundation/Foundation.h>

@interface KHFInvocation : NSObject

// インスタンス化された
+ (NSInvocation *)invocationWithTarget:(id)target selector:(SEL)sel object:(id)arg;
// クラスメソッドを実行する
+ (NSInvocation *)invocationWithClass:(Class)cls selector:(SEL)sel object:(id)arg;

@end
