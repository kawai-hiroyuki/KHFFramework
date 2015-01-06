//
//  KHFJson.m
//  JSONFromFile
//
//  Created by obumin on 2014/11/25.
//  Copyright (c) 2014年 Kawai Hiroyuki. All rights reserved.
//

#import "KHFJson.h"

@implementation KHFJson

// ファイルからJSONファイルを読み込む
+ (id)loadFromFile:(NSString *)jsonFilePath
{
    NSData *data = [NSData dataWithContentsOfFile:jsonFilePath];
    NSError *error = nil;
    id json = [NSJSONSerialization JSONObjectWithData:data
                                              options:kNilOptions
                                                error:&error];
    return json;
}

// ファイルからJSONファイルを読み込む（エラーメッセージ付）
+ (id)loadFromFile:(NSString *)jsonFilePath error:(NSError **)error
{
    NSData *data = [NSData dataWithContentsOfFile:jsonFilePath];
//    NSError *error = nil;
    id json = [NSJSONSerialization JSONObjectWithData:data
                                              options:kNilOptions
                                                error:error];
    // エラーの場合はnilを返す
    if (error) return nil;
    
    return json;
}

// DictionaryからJSON形式のNSStringを作成する
+ (NSString *)stringFromDictionary:(NSDictionary *)dictionary
{
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:2 error:&error];
    NSString *jsonStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];

    return jsonStr;
}

@end
