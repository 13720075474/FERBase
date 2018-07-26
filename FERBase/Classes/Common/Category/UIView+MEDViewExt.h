//
//  UIView+MEDViewExt.h
//  MEDThyroid
//
//  Created by 夏帅 on 15/7/9.
//  Copyright (c) 2015年 Jayce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MEDViewExt)

- (CGFloat)getViewWidth;
- (CGFloat)getViewHeight;
- (CGFloat)getViewX;
- (CGFloat)getViewY;

- (CGFloat)x;
- (CGFloat)y;
- (CGFloat)width;
- (CGFloat)height;

- (void)setX:(CGFloat)x;
- (void)setY:(CGFloat)y;
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic) CGFloat left;

@property (nonatomic) CGFloat top;

@property (nonatomic) CGFloat right;

@property (nonatomic) CGFloat bottom;

@end
