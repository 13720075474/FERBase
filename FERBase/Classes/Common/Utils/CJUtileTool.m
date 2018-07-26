//
//  CJUtileTool.m
//  HugeCollectionProject
//
//  Created by 贾子权 on 2017/5/12.
//  Copyright © 2017年 Chanjet. All rights reserved.
//

#import "CJUtileTool.h"

@implementation CJUtileTool
+(instancetype)sharedInstance
{
    static CJUtileTool *_instance = nil;
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init] ;
    }) ;
    
    return _instance ;
}

+(id) allocWithZone:(struct _NSZone *)zone
{
    return [CJUtileTool sharedInstance] ;
}

-(id) copyWithZone:(struct _NSZone *)zone
{
    return [CJUtileTool  sharedInstance] ;
    
}

@end
