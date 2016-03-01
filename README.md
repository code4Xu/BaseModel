# BaseModel
fillModel
子类继承此类,请求数据后填充Dictionary即可
忽略服务器传回的null字段.
为防止id和description与NSObject自带字段重复.重新命名为类名+id/description
调试时po+model实例名可以直接输出description

比如 CouponModel继承于BaseModel
CouponModel *model = [[CouponModel alloc] init];
[model fillModelWithDict:responseobj];
或者CouponModel *model = [[CouponModel alloc] initWithDic:responseobj];
