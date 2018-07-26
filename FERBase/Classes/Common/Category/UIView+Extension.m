//
//  UIView+Extension.m
//  HugeCollectionProject
//
//  Created by 贾子权 on 2017/4/26.
//  Copyright © 2017年 Chanjet. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
- (void)viewChangeBordWithWidth:(CGFloat) bordWidth{
    
      
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = [UIColor clearColor].CGColor;
    self.layer.cornerRadius = bordWidth;
}
@end
