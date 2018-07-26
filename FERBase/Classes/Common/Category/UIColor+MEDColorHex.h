//
//  UIColor+MEDColorHex.h
//  MEDThyroid
//
//  Created by 夏帅 on 15/7/9.
//  Copyright (c) 2015年 Jayce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (MEDColorHex)

+ (UIColor *) colorWithHexRGB:(NSInteger) hexRGB;
+ (UIColor *) colorWithHexRGB:(NSInteger) hexRGB Alpha:(CGFloat) alpha;
+ (UIColor *) colorWithHexARGB:(NSInteger) hexARGB;
+ (UIColor *)colorWithHEX:(NSString *)HEXColorStr alpha:(CGFloat)alphaValue;

@end
