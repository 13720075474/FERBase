//
//  UIButton+MEDButtonExt.m
//  MEDThyroid
//
//  Created by 夏帅 on 15/7/9.
//  Copyright (c) 2015年 Jayce. All rights reserved.
//

#import "UIButton+MEDButtonExt.h"

@implementation UIButton (MEDButtonExt)

- (void)addClickAction:(SEL)sel WithTarget:(id)target
{
    [self addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
}

@end
