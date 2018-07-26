//
//  NSString+MEDStringExt.m
//  MEDThyroid
//
//  Created by 夏帅 on 15/7/9.
//  Copyright (c) 2015年 Jayce. All rights reserved.
//

#import "NSString+MEDStringExt.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MEDStringExt)

- (unsigned long long)fileSize
{
    unsigned long long size = 0;
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL isDirectory = NO;
    BOOL exists = [mgr fileExistsAtPath:self isDirectory:&isDirectory];
    if (!exists) return size;
    if (isDirectory) {
        NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:self];
        for (NSString *subpath in enumerator) {
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            size += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;
        }
    } else {
        size = [mgr attributesOfItemAtPath:self error:nil].fileSize;
    }
    return size;
}

+ (NSString *)intervalSinceNow: (NSString *) theDate
{
    NSTimeInterval late= [theDate doubleValue];
    
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    
    NSTimeInterval cha=now-late;
    
    if ((cha / 60) < 1) {
        timeString = [NSString stringWithFormat:@"刚才"];
    }
    if (cha/3600<1 && (cha / 60) > 1) {
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
        
    }
    if (cha/3600>1&&cha/86400<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    }
    if (cha/86400>1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@天前", timeString];
        
    }
    return timeString;
}

- (BOOL)isExistStr: (NSString *)str CaseInsensitive: (BOOL)caseInsensitive
{
    if (str == nil) {
        return NO;
    }
    
    if (caseInsensitive) {                                  //区分大小写
        NSRange range = [self rangeOfString:str];
        if (range.location != NSNotFound) {
            return YES;
        }
    } else {                                                //不区分大小写
        
        for (NSInteger i = 0; self.length - i >= str.length; i ++) {
            NSString *tmpStr = [self substringWithRange:NSMakeRange(i, str.length)];
            if ([tmpStr caseInsensitiveCompare:str] == 0) {
                return YES;
            }
        }
    }
    return NO;
}

//利用正则表达式验证邮箱
+(BOOL)isValidateEmail:(NSString *)email {
    if (!email || [email isKindOfClass:[NSNull class]] || email.length < 1) {
        return NO;
    }
    //    NSString *emailRegex = @"^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$";
    NSString *emailRegex = @"^[a-zA-Z0-9][a-zA-Z0-9_\\.]+@[a-zA-Z0-9_]+\\.[a-zA-Z0-9_\\.]+$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//手机号码正则表达式验证
+(BOOL)isValidatePhone:(NSString*)phone
{
    if (!phone || [phone isKindOfClass:[NSNull class]] || [phone length] == 0) {
        return NO;
    }
    
    NSString *phoneRegex = @"^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|4|5|6|7|8|9]|170)\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:phone];
}

//利用正则表达式验证邮编
+(BOOL)isValidZipcode:(NSString*)value
{
    if ([value isEqualToString:@""] || value == nil) {
        return FALSE;
    }
    const char *cvalue = [value UTF8String];
    NSInteger len = strlen(cvalue);
    if (len != 6) {
        return FALSE;
    }
    for (int i = 0; i < len; i++)
    {
        if (!(cvalue[i] >= '0' && cvalue[i] <= '9'))
        {
            return FALSE;
        }
    }
    return TRUE;
}

//unicode编码转汉字
+ (NSString *)replaceUnicode:(NSString *)unicodeStr
{
    
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}

+(NSString *) utf8ToUnicode:(NSString *)string
{
    
    NSUInteger length = [string length];
    
    NSMutableString *s = [NSMutableString stringWithCapacity:0];
    
    for (int i = 0;i < length; i++)
        
    {
        
        unichar _char = [string characterAtIndex:i];
        
        //判断是否为英文和数字
        
        if (_char <= '9' && _char >='0') {
            
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i,1)]];
            
        } else if(_char >='a' && _char <= 'z') {
            
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i,1)]];
            
        } else if(_char >='A' && _char <= 'Z') {
            
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i,1)]];
            
        } else {
            
            [s appendFormat:@"\\u%x",[string characterAtIndex:i]];
            
        }
        
    }
    
    return s;
    
}

//判断是否全是空格
- (BOOL)isAllSpace
{
    if (self.length == 0) {
        return YES;
    } else {
        const char *charVlue = [self UTF8String];
        for (int i = 0; i < strlen(charVlue); i++) {
            if (charVlue[i] != ' ') {
                return NO;
            }
        }
    }
    return YES;
}

- (NSString *)useStr:(NSString *)str ReplaceStr: (NSString *)reStr
{
    NSMutableString *string = [NSMutableString stringWithString:self];
    NSRange range = [string rangeOfString:reStr];
    while (range.location != NSNotFound) {
        [string replaceCharactersInRange:range withString:str];
        range = [string rangeOfString:reStr];
    }
    return string;
}

- (NSString *) stringFromMD5
{
    
    if(self == nil || [self length] == 0)
        return nil;
    
    const char *value = [self UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (uint32_t)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}

-(BOOL)isIncludeSpecialCharact
{
    NSRange urgentRange = [self rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @"-/:;()$&@\".,?!'[]{}#%^*+=_\\|~<>€£¥•.,?!'，。？！…～：“—^_^《【、；「」‘’】》"]];
    if (urgentRange.location == NSNotFound)
    {
        return NO;
    }
    return YES;
}

- (BOOL)isAllNumber
{
    NSRegularExpression *tNumRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    //符合數字條件的有幾個字元
    NSUInteger tNumMatchCount = [tNumRegularExpression numberOfMatchesInString:self
                                                                       options:NSMatchingReportProgress
                                                                         range:NSMakeRange(0, self.length)];
    if (self.length == tNumMatchCount) {
        return YES;
    }
    return NO;
}

- (BOOL)isContainMetacharacter
{
    NSRange range = [self rangeOfString:@"@"];
    if (range.location == NSNotFound) {
        return NO;
    }
    return YES;
}

- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    NSDictionary *dic = @{NSFontAttributeName : font,
                          NSStrikethroughStyleAttributeName : @(lineBreakMode)};
    CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size;
}

- (CGSize)sizeWithFont:(UIFont *)font
{
    return [self sizeWithAttributes:@{NSFontAttributeName : font}];
}

- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil];
    return rect.size;
}

+ (NSString *)chooseStr:(NSString *)tempStr andSubStr:(NSString *)subStr
{
    NSMutableString * muStr = [NSMutableString stringWithString:tempStr];
    NSString *getStr;
    NSRange range = [muStr rangeOfString:subStr];
    
    if (range.location != NSNotFound) {
        
        if (range.length == 0) {
            getStr = tempStr;
        } else {
            getStr = [tempStr substringToIndex:range.location];
        }
    } else {
        getStr = tempStr;
    }

    //NSLog(@"getStr:%@",getStr);
    return getStr;
}

+ (NSString *)chooseStr:(NSString *)tempStr from:(NSString *)from to:(NSString *)to
{
    NSMutableString * muStr = [NSMutableString stringWithString:tempStr];
    NSString *getStr;
    NSRange fromRange = [muStr rangeOfString:from];
    NSRange toRange = [muStr rangeOfString:to];
    
    if (fromRange.location != NSNotFound) {
        
        getStr = [tempStr substringWithRange:NSMakeRange(fromRange.location+1, toRange.location-fromRange.location-1)];
    } else {
        getStr = @"";
    }

    //NSLog(@"getStrgetStr:%@",getStr);
    return getStr;
}

+ (CGFloat)getHeightView:(NSString*)str andViewWidth:(NSInteger)width
{
    UILabel *detialLable = [[UILabel alloc]init];
    detialLable.text = [NSString stringWithFormat:@"        %@",str];
    CGFloat contentW = width - detialLable.frame.origin.x - 40;
    // label的字体 HelveticaNeue  Courier
    //    detialLable.backgroundColor = [UIColor whiteColor];
    UIFont *fnt = [UIFont fontWithName:@"HelveticaNeue" size:12.0f];
    detialLable.font = fnt;
    detialLable.numberOfLines = 0;
    detialLable.lineBreakMode = NSLineBreakByWordWrapping;
    // iOS7中用以下方法替代过时的iOS6中的sizeWithFont:constrainedToSize:lineBreakMode:方法
    CGRect tmpRect = [detialLable.text boundingRectWithSize:CGSizeMake(contentW, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt,NSFontAttributeName, nil] context:nil];
    
    // 高度H
    CGFloat contentH = tmpRect.size.height;
    //NSLog(@"调整后的显示宽度:%f,显示高度:%f",contentW,contentH);
    
    CGFloat height;
    if ((!str)||([str isEqualToString:@""])) {
        height = 20;
    } else {
        height = contentH+20;
    }
    
    return height;
}


+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

- (NSString *)subStringFrom:(NSString *)startString to:(NSString *)endString{
    
    NSRange startRange = [self rangeOfString:startString];
    NSRange endRange = [self rangeOfString:endString];
    NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
    return [self substringWithRange:range];
    
}


@end
