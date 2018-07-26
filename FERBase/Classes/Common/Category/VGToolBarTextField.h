//
//  ToolBarTextField.h
//  Vgo
//
//  Created by David Qu on 15/4/11.
//  Copyright (c) 2015年 www.xjh.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VGToolBarTextFieldDelegate <UITextFieldDelegate>

- (void)doneButtonClicked:(id)sender;

- (void)cancelButtonClicked:(id)sender;

@end

@interface VGToolBarTextField : UITextField
{
    UIToolbar  *_keyboardDoneButtonBar;
    
    id<VGToolBarTextFieldDelegate> __weak toolBarDelegate_;
}

@property (nonatomic, strong) UIToolbar *keyboardDoneButtonBar;

@property (nonatomic, strong) NSString *doneButtonTitle;

@property (nonatomic, weak) id <VGToolBarTextFieldDelegate> toolBarDelegate;

- (id)initWithFrame:(CGRect)frame doneTitle:(NSString *)dtitle;

@end
