//
//  CJUtileTool.h
//  HugeCollectionProject
//
//  Created by 贾子权 on 2017/5/12.
//  Copyright © 2017年 Chanjet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJUtileTool : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, strong) NSString *loginId;
//token字符串
@property (nonatomic, strong) NSString *accessToken;
//token字符串
@property (nonatomic, strong) NSString *tokenType;
//合作者身份ID
@property (nonatomic, strong) NSString *partnerId;
//子商户号
@property (nonatomic, strong) NSString *merId;
//登录类型
@property (nonatomic, strong) NSString *idType;
//收款方式
@property (nonatomic, strong) NSArray *payMethodlistArray;

@end
