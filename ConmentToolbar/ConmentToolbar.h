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

- (void)toolbarBecomeFirstResponder:(ConmentToolbar *)toolbar;

- (void)toolbar:(ConmentToolbar *)toolbar changeTextWithTextH:(NSInteger)textH;


@end


@interface ConmentToolbar : UIView

@property (nonatomic, weak) id <ConmentToolbarDelegate> delegate;

@property (nonatomic, strong) NSString *placeholder; //!< 占位文字

@property (nonatomic, strong) UIColor *placeholderColor; //!< 占位文字的颜色

@property (nonatomic, assign) NSInteger maxNumbersOfLine; //!< 最大行数

@property (nonatomic, assign) CGFloat fontSize; //!< 字体大小

@property (nonatomic, strong) UIColor *cursorColor; //!< 光标颜色

@end
