//
//  NSObject+KHFObject.h
//  SelectorFromString
//
//  Created by obumin on 2014/12/24.
//  Copyright (c) 2014年 Kawai Hiroyuki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Selector)

// プロパティを文字列から生成し値を格納する
- (id)setPropertyFromString:(NSString *)aPropertyName withObject:(id)object;
// プロパティを文字列から生成し値を格納する（CoreDataの場合はこちらを使うとよい）
- (id)setPropertyFromString:(NSString *)aPropertyName withObject:(id)object afterDelay:(NSTimeInterval)delay;

// プロパティを文字列から生成し値を返す
- (id)propertyFromString:(NSString *)aPropertyName;

@end
