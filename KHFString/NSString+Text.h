//
//  KHFString+Text.h
//  Shikoku88
//
//  Created by obumin on 2014/12/19.
//  Copyright (c) 2014年 Kawai Hiroyuki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Text)

+ (NSArray *)arrayFromString:(NSString *)string;

// 最初の文字だけ大文字にする
// http://qiita.com/eggmobile/items/da3e85fdce3e5858ff98
+ (NSString *)capitalizeFirstLetter:(NSString *)string;

@end
