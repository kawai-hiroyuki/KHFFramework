//
//  KHFPlaceHolderTextView.h
//  PlaceHolderTextView
//
//  Created by obumin on 2014/11/08.
//  Copyright (c) 2014年 Kawai Hiroyuki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KHFPlaceHolderTextView : UITextView

@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;

@end
