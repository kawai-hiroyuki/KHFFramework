//
//  NSObject+KHFObject.m
//  SelectorFromString
//
//  Created by obumin on 2014/12/24.
//  Copyright (c) 2014年 Kawai Hiroyuki. All rights reserved.
//

#import "NSObject+Selector.h"

@implementation NSObject (Selector)


// プロパティを文字列から生成し値を格納する
- (id)setPropertyFromString:(NSString *)aPropertyName withObject:(id)object
{
    // プロパティにデータを入れるためにsetterを文字列から生成する
    NSString *capitalisedSentence = [aPropertyName
                                     stringByReplacingCharactersInRange:NSMakeRange(0,1)
                                     withString:[[aPropertyName  substringToIndex:1] capitalizedString]];
    
    
    NSString *selectorName = [NSString stringWithFormat:@"set%@:", capitalisedSentence];
    SEL selector = NSSelectorFromString(selectorName);
        
    if ([self respondsToSelector:selector]) {
        // 警告「PerformSelector may cause a leak because its selector is unknown」への対処 - 甘いものが好きです
        // http://captainshadow.hatenablog.com/entry/20121114/1352834276
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        return [self performSelector:selector withObject:object];
#pragma clang diagnostic pop
    }
    
    return nil;
}

// プロパティを文字列から生成し値を格納する（CoreDataの場合はこちらを使うとよい）
- (id)setPropertyFromString:(NSString *)aPropertyName withObject:(id)object afterDelay:(NSTimeInterval)delay
{
    // プロパティにデータを入れるためにsetterを文字列から生成する
    NSString *capitalisedSentence = [aPropertyName
                                     stringByReplacingCharactersInRange:NSMakeRange(0,1)
                                     withString:[[aPropertyName  substringToIndex:1] capitalizedString]];
    
    
    NSString *selectorName = [NSString stringWithFormat:@"set%@:", capitalisedSentence];
    SEL selector = NSSelectorFromString(selectorName);
    
    if ([self respondsToSelector:selector]) {
        
        [self performSelector:selector withObject:object afterDelay:delay];
    }
    
    return nil;
}

// プロパティを文字列から生成し値を返す
- (id)propertyFromString:(NSString *)aPropertyName
{
    SEL selector = NSSelectorFromString(aPropertyName);
    
    NSLog(@"selector=%@", NSStringFromSelector(selector));
    
    if ([self respondsToSelector:selector]) {
        // 警告「PerformSelector may cause a leak because its selector is unknown」への対処 - 甘いものが好きです
        // http://captainshadow.hatenablog.com/entry/20121114/1352834276
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        return [self performSelector:selector];
#pragma clang diagnostic pop
    }
    
    return nil;

}

@end
