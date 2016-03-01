//
//  BaseModel.m
//  CreditBank
//
//  Created by XuTianyu on 15/10/9.
//  Copyright © 2015年 lakala. All rights reserved.
//

#import "BaseModel.h"
#import <objc/runtime.h>

@implementation BaseModel
-(instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self fillModelWithDict:dic];
    }
    return self;
}
-(NSMutableArray *)getAllkey
{
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    NSMutableArray *keys = [[NSMutableArray alloc] init];
    for (i=0; i<outCount; i++) {
        objc_property_t property = properties[i];
        NSString * key = [[NSString alloc]initWithCString:property_getName(property)  encoding:NSUTF8StringEncoding];
        [keys addObject:key];
    }
    
    return keys;
}
/**
 *  获取属性名称和值
 *
 *  @return dic
 */
- (NSDictionary *)properties_aps
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    return props;
}
-(NSString *)description
{
    return [NSString stringWithFormat:@"<%@:   %p,  %@>",[self class],self,[self properties_aps]];
}
- (void)fillModelWithDict:(NSDictionary *)dict
{
    if (dict == nil)
    {
        return;
    }
    
    NSMutableArray *selfKeys = [self getAllkey];
    for (NSString *k in [dict allKeys])
    {
        if ([k isEqualToString:@""])
        {
            // do something else
        }
        @try
        {
            NSString *value =  [NSString stringWithFormat:@"%@",[dict objectForKey:k]];
            //获取到的”<null>“ 是字符串 不是nil
            if ([value isEqualToString:@"<null>"])
            {
                if ([selfKeys containsObject:k])
                    [self setValue:nil forKey:k];
            }
            else if([k isEqualToString:@"id"]||[k isEqualToString:@"description"])
            {
                //为防止服务器返回字段与系统持有冲突,默认填充为类名+key
                NSString *newKey = [NSString stringWithFormat:@"%@%@",[self class],k];
                
                [self setValue:[dict objectForKey:k] forKey:newKey];
                
            }else
            {
                if ([selfKeys containsObject:k])
                    [self setValue:[dict objectForKey:k] forKey:k];
            }
            
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
            
        }
        
        
        
    }
}
#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    NSLog(@"should implemented in subclass");
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    NSLog(@"should implemented in subclass");
    return self;
}
@end
