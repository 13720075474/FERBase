//
//  SelectButton.h
//  CJScanCodePay
//
//  Created by 贾子权 on 2016/11/21.
//  Copyright © 2016年 Chanjet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectButton : UIButton
+ (instancetype)createButtonWithImageName:(NSString *)imgName title:(NSString *)title titleColor:(UIColor *)titleColor frame:(CGRect)btnFrame target:(id)target action:(SEL)action;
@end
