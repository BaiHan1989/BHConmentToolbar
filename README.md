# BHConmentToolbar
可以折行的评论条，可以设置placeholder，文字大小，占位文字颜色。操作简单

评论条的高度根据文字大小动态改变，默认fontSize  = 14

把如何使用的放在这吧！
```objective-c
    ConmentToolbar *ct = [[ConmentToolbar alloc] init];
    ct.fontSize = 30;
    ct.placeholder = @"占位文字";
    ct.cursorColor = [UIColor redColor];
    ct.placeholderColor = [UIColor greenColor];
    ct.maxNumbersOfLine = 3;
    ct.delegate = self;
    [self.view addSubview:ct];
```

目前只是折行的基础功能，觉得还行， 麻烦给颗星星。


