//
//  ConmentToolbar.m
//  ConmentToolbar
//
//  Created by bh on 2018/3/12.
//  Copyright © 2018年 bh. All rights reserved.
//

#import "ConmentToolbar.h"

@interface ConmentToolbar () <UITextViewDelegate>


/**
 textView
 */
@property (strong, nonatomic) UITextView *textView;

/**
 占位文字
 */
@property (strong, nonatomic) UILabel *placeholderLb;

/**
 textView的初始高度
 */
@property (assign, nonatomic) CGFloat initTextViewH;

/**
 toolbar初始Y值
 */
@property (assign, nonatomic) CGFloat initY;

/**
 第一次进入，记录初始值
 */
@property (assign, nonatomic) BOOL isFirst;


@end

@implementation ConmentToolbar


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
        [self addNoti];
        
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
    [self addNoti];
}

- (void)addNoti {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)setupUI {
    
    self.isFirst = YES;
    self.maxNumbersOfLine = 4;
    self.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0];
    self.placeholderLb.text = @"评论";
    [self addSubview:self.textView];
    [self addSubview:self.placeholderLb];
    
}


- (void)layoutSubviews {
    
    
    CGFloat tvW = self.bounds.size.width - 10;
    CGFloat tvH = self.bounds.size.height - 10;
    CGFloat tvX = 5;
    CGFloat tvY = (self.bounds.size.height - tvH) * 0.5;
    self.textView.frame = CGRectMake(tvX, tvY, tvW, tvH);
    self.placeholderLb.frame = CGRectMake(12, tvY, tvW, tvH);
    
    // 因为折行会重复调用该方法，而我们只需要一次该值
    if (self.isFirst) {
        self.initTextViewH = self.textView.bounds.size.height;
        self.initY = self.frame.origin.y;
    }
    
}

// 文本改变时候调用
- (void)textDidChange {

    self.isFirst = NO;
    // 如果textView 有文字 placeholder隐藏
    self.placeholderLb.hidden = self.textView.hasText;
    
//    NSLog(@"%@",self.textView.font);
    // textView的宽度 - 左侧光标据左侧的距离 - 右侧折行据右侧距离
    CGFloat w = self.textView.bounds.size.width - 10;
    CGSize maxSize = CGSizeMake(w, MAXFLOAT);
    // 计算文本的宽度
    CGSize textSize = [self.textView.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.textView.font} context:nil].size;
    
    // 计算行数 文字的高度 / 控件高度
    // 文字的总高度
    CGFloat textH = ceil(textSize.height);
    CGFloat tvH = self.initTextViewH - self.textView.textContainerInset.top - self.textView.textContainerInset.bottom;
    CGFloat row = ceil(textH / tvH);
    
    NSLog(@"%f -- %f",textH,tvH);
    NSLog(@"row --- %f",row);
    
    if (row > self.maxNumbersOfLine) {
        self.textView.scrollEnabled = YES;
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            // 修改toolBar的 y 和 height
            CGRect frame = self.frame;
            frame.size.height = 44 + tvH * (row - 1);
            frame.origin.y = self.initY - tvH * (row - 1);
            self.frame = frame;
            
            // 修改textView
            CGFloat tvW = self.bounds.size.width - 10;
            CGFloat tvH = self.bounds.size.height - 10;
            CGFloat tvX = 5;
            CGFloat tvY = (self.bounds.size.height - tvH) * 0.5;
            self.textView.frame = CGRectMake(tvX, tvY, tvW, tvH);
            
        }];
       
        self.textView.scrollEnabled = NO;
    }

}

- (UITextView *)textView {
    if (!_textView) {
        
        UITextView *textView = [[UITextView alloc] init];
        textView.font = [UIFont systemFontOfSize:14];
        textView.backgroundColor = [UIColor whiteColor];
        textView.scrollEnabled = NO;
        textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        textView.layer.borderWidth = 1.0;
        textView.layer.cornerRadius = 5;
        textView.layer.masksToBounds = YES;
        textView.returnKeyType = UIReturnKeySend;
        textView.delegate = self;
        textView.enablesReturnKeyAutomatically = YES;
        _textView = textView;
        
    }
    
    return _textView;
}

- (UILabel *)placeholderLb {
    if (!_placeholderLb) {
        
        UILabel *placeholderLb = [[UILabel alloc] init];
        placeholderLb.font = self.textView.font;
        placeholderLb.textColor = [UIColor lightGrayColor];
        _placeholderLb = placeholderLb;
    }
    
    return _placeholderLb;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    
    self.placeholderLb.text = placeholder;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    
    self.placeholderLb.textColor = placeholderColor;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        
        NSLog(@"点击了发送按钮");
        
        if ([self.delegate respondsToSelector:@selector(toolbar:didClickSendButtonWithText:)]) {
            [self.delegate toolbar:self didClickSendButtonWithText:self.textView.text];
        }
        self.textView.text = @"";
        [self.textView resignFirstResponder];
        [self textDidChange];
        return NO;
    }
    
    return YES;
    
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    if ([self.delegate respondsToSelector:@selector(toolbarBecomeFirstResponder:)]) {
        [self.delegate toolbarBecomeFirstResponder:self];
    }
    
    return YES;
}

@end
