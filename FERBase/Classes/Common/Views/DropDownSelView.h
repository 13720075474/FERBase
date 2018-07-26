//
//  LifeDropDownSelView.h
//  CJScanCodePay
//
//  Created by 贾子权 on 2016/11/21.
//  Copyright © 2016年 Chanjet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFMacro.h"
@interface DropDownSelView : UIView<UITableViewDelegate,UITableViewDataSource>
typedef void (^ChooseConditionBlock)(NSString *, NSMutableArray *);

@property (nonatomic, copy) ChooseConditionBlock chooseConditionBlock;

@property (nonatomic, strong) NSMutableArray *dataSourceArr;


/* 默认显示的 */
@property (nonatomic, strong) NSArray *defaulTitleArray;


/* 分类按钮 数组 */
@property (nonatomic, strong) NSMutableArray *titleBtnArr;

/* 分类内容 动画起始位置 */
@property (nonatomic, assign) CGFloat startY;

- (void)show;
//- (void)freshDataSourceArray:(NSArray *)sourceArray andDefaulTitleArray:(NSArray *)titleAray;

@end
