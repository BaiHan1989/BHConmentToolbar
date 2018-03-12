//
//  ConmentToolbar.h
//  ConmentToolbar
//
//  Created by bh on 2018/3/12.
//  Copyright © 2018年 bh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ConmentToolbar;

@protocol ConmentToolbarDelegate <NSObject>

@optional

- (void)toolbar:(ConmentToolbar *)toolbar didClickSendButtonWithText:(NSString *)text;

@end


@interface ConmentToolbar : UIView

@property (weak, nonatomic) id <ConmentToolbarDelegate> delegate;

/**
 占位文字
 */
@property (strong, nonatomic) NSString *placeholder;

/**
 占位文字的颜色
 */
@property (strong, nonatomic) UIColor *placeholderColor;

/**
 最大行数
 */
@property (assign, nonatomic) NSInteger maxNumbersOfLine;

@end
