//
//  NSObject+isEmpty.m
//  MEDThyroid
//
//  Created by Harry on 16/2/29.
//  Copyright © 2016年 Jayce. All rights reserved.
//

#import "NSObject+isEmpty.h"

@implementation NSObject (isEmpty)
-(BOOL)isNotEmpty{
    return !(self == nil
             || [self isKindOfClass:[NSNull class]]
             || ([self respondsToSelector:@selector(length)]
                 && [(NSData *)self length] == 0)
             || ([self respondsToSelector:@selector(count)]
                 && [(NSArray *)self count] == 0));
    
}
@end
