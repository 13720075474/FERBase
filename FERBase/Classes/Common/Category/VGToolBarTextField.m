//
//  ToolBarTextField.m
//  Vgo
//
//  Created by David Qu on 15/4/11.
//  Copyright (c) 2015年 www.xjh.com. All rights reserved.
//

#import "VGToolBarTextField.h"
//#import "SNDefines.h"
//#import "SystemInfo.h"

@implementation VGToolBarTextField

@synthesize keyboardDoneButtonBar = _keyboardDoneButtonBar;

@synthesize toolBarDelegate = toolBarDelegate_;

- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.inputAccessoryView = self.keyboardDoneButtonBar;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        self.inputAccessoryView = self.keyboardDoneButtonBar;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
     self.inputAccessoryView = self.keyboardDoneButtonBar;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame doneTitle:(NSString *)dtitle
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _doneButtonTitle = dtitle;
        self.inputAccessoryView = self.keyboardDoneButtonBar;
    }
    return self;
}


-(UIToolbar*)keyboardDoneButtonBar{
    
    if(!_keyboardDoneButtonBar){
        
        _keyboardDoneButtonBar= [[UIToolbar alloc] init];
     
        if ([[UIDevice currentDevice].systemVersion doubleValue]
             >= 7.0) {
            _keyboardDoneButtonBar.barStyle = UIBarStyleDefault;
        }else{
            _keyboardDoneButtonBar.barStyle = UIBarStyleBlackTranslucent;
        }
        
         _keyboardDoneButtonBar.barTintColor =  [UIColor blackColor];
        
        [_keyboardDoneButtonBar sizeToFit];
        
        
        UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace 
                                                                                  target:nil
                                                                                  action:nil];
        
        
        
        UIBarButtonItem* cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"下一项"
                                                                          style:UIBarButtonItemStylePlain target:self
                                                                         action:@selector(CancelClicked:)];
           cancelButton.tintColor = [UIColor whiteColor];
        if (!_doneButtonTitle || _doneButtonTitle.length == 0) {
            _doneButtonTitle = @"确定";
        }
        UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:_doneButtonTitle
                                                                        style:UIBarButtonItemStylePlain target:self
                                                                       action:@selector(DoneClicked:)];
        doneButton.tintColor = [UIColor whiteColor];
        [_keyboardDoneButtonBar setItems:[NSArray arrayWithObjects:cancelButton,flexItem,doneButton, nil]];
        
    }
    
    return _keyboardDoneButtonBar;
}

- (void)DoneClicked:(id)sender
{
   if ([toolBarDelegate_ conformsToProtocol:@protocol(VGToolBarTextFieldDelegate)])
   {
        if ([toolBarDelegate_ respondsToSelector:@selector(doneButtonClicked:)])
        {
            [toolBarDelegate_ doneButtonClicked:(id)sender];
        }
        else
       {
           [self resignFirstResponder];
        }
    }
   else
   {
        [self resignFirstResponder];
   }
}

- (void)CancelClicked:(id)sender
{
   if ([toolBarDelegate_ conformsToProtocol:@protocol(VGToolBarTextFieldDelegate)])
   {
        if ([toolBarDelegate_ respondsToSelector:@selector(cancelButtonClicked:)])
        {
            [toolBarDelegate_ cancelButtonClicked:(id)sender];
        }
    }
   // [self resignFirstResponder];
}

@end
