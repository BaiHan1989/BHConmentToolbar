# BHConmentToolbar
类似于微信的评论框，可以设置placeholder，可以折行。使用简单


这个demo的核心代码，和实现思路 在我的简书，就不再这再写一遍了

把如何使用的放在这吧！
```
ConmentToolbar *ct = [[ConmentToolbar alloc] init];
ct.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 44, [UIScreen mainScreen].bounds.size.width, 44);
ct.placeholder = @"哈哈哈";
ct.placeholderColor = [UIColor greenColor];
ct.maxNumbersOfLine = 3;
ct.delegate = self;
[self.view addSubview:ct];
```

具体的就看demo把，有问题的话，在简书直接留言，觉得还行， 麻烦给颗星星
