//
//  LifeDropDownSelView.m
//  CJScanCodePay
//
//  Created by 贾子权 on 2016/11/21.
//  Copyright © 2016年 Chanjet. All rights reserved.
//

#import "DropDownSelView.h"
#import "SelectButton.h"
#import "UIView+CFFrame.h"
#import "UIView+Extension.h"
#define kTitleBarHeight 45
#define kViewTagConstant 1  // 所有tag都加上这个 防止出现为0的tag

@interface  DropDownSelView ()

/* 分类 classifyView */
@property (nonatomic, strong) UIView *titleBar;
/*  权限Lavel */
@property (nonatomic, strong) UILabel *titleLabel;

/* 整个屏幕的 背景 半透明View */
@property (nonatomic, strong) UIView *bgView;

/**
 *  cell为筛选的条件
 */
@property (nonatomic, strong) UITableView *dropDownMenuTableView;

@property (nonatomic, retain) UIToolbar      *keyboardDoneButtonBar;

/**
 *  数据源--一维数组 (每一列的条件标题)
 */
@property (nonatomic, strong) NSArray *dataSource;

/* 最后点击的按钮 */
@property (nonatomic, strong) UIButton *lastClickedBtn;
@property (nonatomic, copy)   NSString *chooseDateStr;
@end

@implementation DropDownSelView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
      //  self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.titleBar];
        [self addSubview:self.titleLabel];
    }
    return self;
}
- (UILabel *)titleLabel{
     if (!_titleLabel) {
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0, 40.0f, kTitleBarHeight)];
    _titleLabel.textColor = [UIColor whiteColor];
    [_titleLabel setText:@"权限"];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.font = [UIFont boldSystemFontOfSize:17];
                   }
    return _titleLabel;
}
#pragma mark - lazy
/* 分类 classifyView */
- (UIView *)titleBar
{
    if (!_titleBar) {
        _titleBar = [[UIView alloc] initWithFrame:CGRectMake(50.0f, 0, 250, kTitleBarHeight)];
    
;
    }
    return _titleBar;
}
#pragma mark - setter
- (void)setDataSourceArr:(NSMutableArray *)dataSourceArr
{
    _dataSourceArr = dataSourceArr;
    
    self.titleBtnArr = [[NSMutableArray alloc] init];
    
    CGFloat btnW = 260/dataSourceArr.count;
    CGFloat btnH = kTitleBarHeight;
    
    for (NSInteger i=0; i<dataSourceArr.count; i++) {
        
         SelectButton  *titleBtn = nil;
       
        titleBtn = [SelectButton createButtonWithImageName:@"深灰箭头.png" title:@"" titleColor:CF_Color_TextDarkGrayColor frame:CGRectMake(i*btnW, 0, btnW, btnH) target:self action:@selector(titleBtnClicked:)];
       // titleBtn.backgroundColor = [UIColor yellowColor];
        titleBtn.tag = i+kViewTagConstant;  // 所有tag都加上这个, 防止出现为0的tag
        titleBtn.backgroundColor = [UIColor clearColor];
        [self.titleBar addSubview:titleBtn];
        
        [self.titleBtnArr addObject:titleBtn];  // 分类 按钮数组
    }
    
//    // 中间分割竖线
//    for (NSInteger i=0; i<dataSourceArr.count-1; i++) {
//        UIView *line = [UIView viewWithFrame:CGRectMake(btnW*(i+1), 9, 1, btnH-18) backgroundColor:CF_Color_SepertLineColor];
//        [self.titleBar addSubview:line];
//    }
//    //上部分割线
//    UIView *topLine = [UIView viewWithFrame:CGRectMake(zero, 0, SCREEN_HEIGHT, 1) backgroundColor:CF_Color_SepertLineColor];
//    [self.titleBar addSubview:topLine];
//    //下部分割线
//    UIView *bottomLine = [UIView viewWithFrame:CGRectMake(zero, 44, SCREEN_HEIGHT, 1) backgroundColor:CF_Color_SepertLineColor];
//    [self.titleBar addSubview:bottomLine];
    
}
// 设置文字 默认
- (void)setDefaulTitleArray:(NSArray *)defaulTitleArray
{
    _defaulTitleArray = defaulTitleArray;
    
    for (NSInteger i = 0; i < self.titleBtnArr.count; i++) {
        [self.titleBtnArr[i] setTitle:defaulTitleArray[i] forState:UIControlStateNormal];
        
        
        
    }
    
    
}
#pragma mark - 按钮点击
- (void)titleBtnClicked:(UIButton *)btn
{
    if (btn == _lastClickedBtn) {
        _lastClickedBtn = nil;
          [self removeSubviews];
        [UIView animateWithDuration:0.25 animations:^{
            
            btn.imageView.transform = CGAffineTransformMakeRotation(0);
            
            
        }];

    
    }else{
    _lastClickedBtn = btn;
    
    
    [self removeSubviews];
    self.dataSource = self.dataSourceArr[btn.tag-kViewTagConstant];
    
    // 加上 选择内容
    [self show];
    // 按钮动画
    [self animationWhenClickTitleBtn:btn];
    }
    
}

#pragma mark - lazy
/* 蒙层view */
- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.startY, 300, 44 * self.dataSource.count)];
        _bgView.backgroundColor = [UIColor clearColor];
        _bgView.alpha = 0.8;
    
    }
    return _bgView;
}


#pragma mark - public
// 点击按钮动画
- (void)animationWhenClickTitleBtn:(UIButton *)btn
{
    
    //_lastClickedBtn = btn;
    [UIView animateWithDuration:0.25 animations:^{
                
    btn.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        
    }];
}

/* 分类内容 */
- (UITableView *)dropDownMenuTableView
{
    if (!_dropDownMenuTableView) {
        _dropDownMenuTableView = [[UITableView alloc] init];
        _dropDownMenuTableView.frame = CGRectMake(self.frame.origin.x, self.startY, 300, 0);
        _dropDownMenuTableView.backgroundColor = [UIColor blackColor];
        _dropDownMenuTableView.delegate = self;
        _dropDownMenuTableView.dataSource = self;
        _dropDownMenuTableView.scrollEnabled = NO;
        [_dropDownMenuTableView viewChangeBordWithWidth:4.0f];
        
    }
    return _dropDownMenuTableView;
}

#pragma mark - public
- (void)show {
    
    [self.superview addSubview:self.bgView];
    [self.superview addSubview:self.dropDownMenuTableView];
    
    
    [UIView animateWithDuration:0.25 animations:^{
        self.dropDownMenuTableView.frame = CGRectMake(self.frame.origin.x, self.startY, 300, 44 * self.dataSource.count);
        
    } completion:^(BOOL finished) {
        [self.dropDownMenuTableView reloadData];
    }];
}
- (void)btnCanotEnable{
    
    for (NSInteger i=0; i<self.dataSourceArr.count; i++){
        
        UIButton *btn = self.titleBtnArr[i];
        btn.enabled = NO;
        
    }
}
- (void)removeSubviews
{
    
    // 此处 千万不能写作 !self.bgView?:[self.bgView removeFromSuperview];  会崩
    !_bgView?:[_bgView removeFromSuperview];
    _bgView=nil;
    
    !_dropDownMenuTableView?:[_dropDownMenuTableView removeFromSuperview];
    _dropDownMenuTableView=nil;
    
    self.dataSource = nil;
    
   // [self btnEnable];
    
}
- (void)btnEnable
{
    // 所有 分类按钮  都变为 可点击
    for (NSInteger i=0; i<self.dataSourceArr.count; i++) {
        UIButton *btn = self.titleBtnArr[i];
        btn.enabled = YES;
        
    }
    
}
#pragma mark - UITableViewDelegate/UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }
    
    
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    // KVC
    NSArray *textArr = [self.titleBtnArr valueForKeyPath:@"titleLabel.text"];
    
    
    if ([textArr containsObject:cell.textLabel.text]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.textLabel.textColor = [UIColor blackColor];
        cell.tintColor = [UIColor blackColor];
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.textColor = [UIColor blackColor];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 改变标题展示 及 颜色
    NSMutableArray *currentTitleArr = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < self.dataSourceArr.count; i++) {
        UIButton *btn = self.titleBtnArr[i];
        if (btn == _lastClickedBtn) {
             [btn setTitle:self.dataSource[indexPath.row] forState:UIControlStateNormal];
        }
        [currentTitleArr addObject:btn.titleLabel.text];
        
    }
        // 走block  3目运算,有block则执行;否则不执行
        NSLog(@"%@",self.chooseConditionBlock);
        !self.chooseConditionBlock?:self.chooseConditionBlock(self.dataSource[indexPath.row],currentTitleArr);
        
        // 移除
        [UIView animateWithDuration:0.25 animations:^{
    
            _lastClickedBtn.imageView.transform = CGAffineTransformMakeRotation(0);
    
    
        }];

    _lastClickedBtn = nil;
    [self removeSubviews];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
