//
//  BaseModel.h
//  CreditBank
//
//  Created by XuTianyu on 15/10/9.
//  Copyright © 2015年 lakala. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject
-(instancetype)initWithDic:(NSDictionary *)dic;
- (void)fillModelWithDict:(NSDictionary *)dict;
@end
