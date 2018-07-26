//
//  MEDBackButton.m
//  MEDThyroid
//
//  Created by 夏帅 on 15/7/23.
//  Copyright (c) 2015年 Jayce. All rights reserved.
//

#import "MEDBackButton.h"

@implementation MEDBackButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(15, 17, 10, 18)];
    image.image = [UIImage imageNamed:@"backbt.png"];
    //back-19-31.png
    [self addSubview:image];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
