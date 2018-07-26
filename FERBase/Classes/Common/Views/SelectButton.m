//  SelectButton.m
//  CJScanCodePay
//
//  Created by 贾子权 on 2016/11/21.
//  Copyright © 2016年 Chanjet. All rights reserved.
//

#import "SelectButton.h"

@implementation SelectButton

+ (instancetype)createButtonWithImageName:(NSString *)imgName title:(NSString *)title titleColor:(UIColor *)titleColor frame:(CGRect)btnFrame target:(id)target action:(SEL)action
{
    SelectButton *btn = [self buttonWithType:UIButtonTypeCustom];
    
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    
    [btn sizeToFit];
    btn.frame = btnFrame;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    CGFloat imageWidth = self.imageView.frame.size.width+1;
    
    CGFloat labelWidth = self.titleLabel.frame.size.width+1;
    
    // 图片 位置（右）
    self.imageEdgeInsets = UIEdgeInsetsMake(0, 2.2*labelWidth, 0, -2.2*labelWidth);
    
    
    // 文字 位置（左边）
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -6.3*imageWidth, 0, 6.3*imageWidth);
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
