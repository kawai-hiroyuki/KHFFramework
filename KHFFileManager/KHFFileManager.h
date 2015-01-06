//
//  KHFFileManager.h
//  KHFFileManager
//
//  Created by obumin on 1/5/15.
//  Copyright (c) 2015 Kawai Hiroyuki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KHFFileManager : NSObject

+ (KHFFileManager *)sharedInstance;

- (void)writeTofilePath:(NSString *)filePath text:(NSString *)text;

@end
