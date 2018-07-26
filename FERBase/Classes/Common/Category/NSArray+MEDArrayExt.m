//
//  NSArray+MEDArrayExt.m
//  MEDThyroid
//
//  Created by 夏帅 on 15/7/9.
//  Copyright (c) 2015年 Jayce. All rights reserved.
//

#import "NSArray+MEDArrayExt.h"

@implementation NSArray (MEDArrayExt)

+ (NSArray *)arrayWithReverseArray:(NSArray *)arrToRev
{
    int count = (int)arrToRev.count;
    NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:count];
    for (int i = count-1; i >= 0; i--) {
        [arrM addObject:arrToRev[i]];
    }
    return arrM;
}

@end
@implementation NSArray (Log)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [strM appendFormat:@"\t%@,\n", obj];
    }];
    
    [strM appendString:@")"];
    
    return strM;
}

@end

@implementation NSDictionary (Log)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *strM = [NSMutableString stringWithString:@"{\n"];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [strM appendFormat:@"\t%@ = %@;\n", key, obj];
    }];
    
    [strM appendString:@"}\n"];
    
    return strM;
}
@end
