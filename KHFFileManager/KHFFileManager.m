//
//  KHFFileManager.m
//  KHFFileManager
//
//  Created by obumin on 1/5/15.
//  Copyright (c) 2015 Kawai Hiroyuki. All rights reserved.
//

#import "KHFFileManager.h"

@implementation KHFFileManager

// 共通化したインスタンスを取得（シングルトン）
+ (KHFFileManager*)sharedInstance
{
    static KHFFileManager* sharedSingleton;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSingleton = [[self alloc] initSharedInstance];
    });
    return sharedSingleton;
}


/*** DBの初期化 ***/
- (id)initSharedInstance {
    self = [super init];
    if (self) {
    }
    return self;
}

- (id)init {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (void)writeTofilePath:(NSString *)filePath text:(NSString *)text
{    
    // ファイルマネージャを作成
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 注意．
    // ファイルに書き込もうとしたときに該当のファイルが存在しないとエラーになるため
    // ファイルが存在しない場合は空のファイルを作成する
    
    // ファイルが存在しないか?
//    if (![fileManager fileExistsAtPath:filePath]) { // yes
        // 空のファイルを作成する
        BOOL result = [fileManager createFileAtPath:filePath
                                           contents:[NSData data] attributes:nil];
        if (!result) {
            NSLog(@"ファイルの作成に失敗");
            return;
        }
//    }
    
    // ファイルハンドルを作成する
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
    if (!fileHandle) {
        NSLog(@"ファイルハンドルの作成に失敗");
        return;
    }
    
    // ファイルに書き込むデータ2を作成
    NSData *data = [NSData dataWithBytes:text.UTF8String
                                   length:[text lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
    [fileHandle writeData:data];
    
    // 効率化のためにすぐにファイルに書き込まれずキャッシュされることがある．
    // 「synchronizeFile」メソッドを使用することで
    // キャッシュされた情報を即座に書き込むことが可能．
    [fileHandle synchronizeFile];
    
    // ファイルを閉じる
    [fileHandle closeFile];
    
    NSLog(@"ファイルの書き込みが完了しました．");

}

@end
