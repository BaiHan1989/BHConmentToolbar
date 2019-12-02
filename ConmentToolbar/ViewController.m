//
//  ViewController.m
//  ConmentToolbar
//
//  Created by bh on 2018/3/12.
//  Copyright © 2018年 bh. All rights reserved.
//

#import "ViewController.h"
#import "ConmentToolbar.h"

@interface ViewController () <ConmentToolbarDelegate>
@property (weak, nonatomic) IBOutlet UILabel *textLb;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    ConmentToolbar *ct = [[ConmentToolbar alloc] init];
    ct.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 44, [UIScreen mainScreen].bounds.size.width, 44);
    ct.placeholder = @"哈哈哈";
    ct.fontSize = 20;
    ct.placeholderColor = [UIColor greenColor];
    ct.maxNumbersOfLine = 3;
    ct.delegate = self;
    [self.view addSubview:ct];
    
}

- (void)toolbar:(ConmentToolbar *)toolbar didClickSendButtonWithText:(NSString *)text {
    NSLog(@"text --- %@",text);
    self.textLb.text = text;
}

- (void)toolbarBecomeFirstResponder:(ConmentToolbar *)toolbar {
    
    // 这里可以处理一些逻辑，我的实际项目中，需要将tableView滚动到最顶部，类似于微信展示最底部的评论内容
     
    NSLog(@"成为第一响应者");
}

- (void)toolbar:(ConmentToolbar *)toolbar changeTextWithTextH:(NSInteger)textH {
    // 这里计算出textH，根据实际逻辑来修改，其他控件高度，我的实际项目中，这个部分是调整tableView的transform
    NSLog(@"textH --- %zd",textH);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)keyboardWillChangeFrame:(NSNotification *)noti {
    
    // 获取键盘弹起时间
    CGFloat duration = [noti.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    
    CGRect frame = [noti.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
    CGFloat offsetY = frame.origin.y - [UIScreen mainScreen].bounds.size.height;
    
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, offsetY);
        
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
