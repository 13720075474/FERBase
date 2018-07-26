//
//  NSString+MEDStringExt.h
//  MEDThyroid
//
//  Created by 夏帅 on 15/7/9.
//  Copyright (c) 2015年 Jayce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIView+Extension.h"
@interface NSString (MEDStringExt)

/**
 计算文件大小
 */
- (unsigned long long)fileSize;

//某个时间相对于现在时间差
+ (NSString *) intervalSinceNow: (NSString *) theDate;

//校验手机号
+(BOOL)isValidatePhone:(NSString*)phone;

+(BOOL)isValidZipcode:(NSString*)value;

//邮箱校验
+(BOOL)isValidateEmail:(NSString *)email;

//unicode编码转汉字
+ (NSString *)replaceUnicode:(NSString *)unicodeStr;

//UTF-8转Unicode
+(NSString *) utf8ToUnicode:(NSString *)string;

//检测某个字符串中是否包含某字串
- (BOOL)isExistStr: (NSString *)str CaseInsensitive: (BOOL)caseInsensitive;

//用指定的字符串替换一个字符串中的特定字符串
- (NSString *)useStr:(const NSString *)str ReplaceStr: (const NSString *)reStr;

//返回字符串的MD5形式
- (NSString *) stringFromMD5;

//判断是否全是空格
- (BOOL)isAllSpace;

//判断字符串中是否包含特殊字符
-(BOOL)isIncludeSpecialCharact;

/*!
 *  @brief  是否纯为数字
 *
 *  @return 是否为纯数字
 */
- (BOOL)isAllNumber;

/*!
 *  @brief  是否包含@
 *
 *  @return 是否包含@
 */
- (BOOL)isContainMetacharacter;

//复写iOS7.0之前方法
- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;
- (CGSize)sizeWithFont:(UIFont *)font;
- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

//有一个括号的截取
+ (NSString *)chooseStr:(NSString *)tempStr andSubStr:(NSString *)subStr;

//窃取括号内不得内容
+ (NSString *)chooseStr:(NSString *)tempStr from:(NSString *)from to:(NSString *)to;

//获取自适应文字的高度
+ (CGFloat)getHeightView:(NSString*)str andViewWidth:(NSInteger)width;

//男性基础代谢值
+ (NSString *) getBasalmetabolism:(NSInteger)sex;

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

//截取字符串中两个指定字符串中间的字符串
- (NSString *)subStringFrom:(NSString *)startString to:(NSString *)endString;

@end
