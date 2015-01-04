//
//  KHFString+Text.m
//  Shikoku88
//
//  Created by obumin on 2014/12/19.
//  Copyright (c) 2014年 Kawai Hiroyuki. All rights reserved.
//

#import "NSString+Text.h"

@implementation NSString (Text)

// 文字列を改行ごとに分割する処理
// https://developer.apple.com/jp/devcenter/ios/library/documentation/Strings.pdf
+ (NSArray *)arrayFromString:(NSString *)string
{
    NSUInteger length = [string length];
    NSUInteger paraStart = 0, paraEnd = 0, contentsEnd = 0;
    NSMutableArray *array = [NSMutableArray array];
    NSRange currentRange;
    while (paraEnd < length) {
        [string getParagraphStart:&paraStart end:&paraEnd
                      contentsEnd:&contentsEnd forRange:NSMakeRange(paraEnd, 0)];
        currentRange = NSMakeRange(paraStart, contentsEnd - paraStart);
        [array addObject:[string substringWithRange:currentRange]];
    }
    return array;
}

// 最初の文字だけ大文字にする
// http://qiita.com/eggmobile/items/da3e85fdce3e5858ff98
+ (NSString *)capitalizeFirstLetter:(NSString *)string
{
    NSString *capitalisedSentence = [string stringByReplacingCharactersInRange:NSMakeRange(0,1)
                                                                    withString:[[string  substringToIndex:1] capitalizedString]];
    return capitalisedSentence;
}

@end
