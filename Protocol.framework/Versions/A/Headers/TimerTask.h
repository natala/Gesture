//
//  TimerTask.h
//  NewProtocol
//
//  Created by chendy on 13-9-9.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "JSONObject.h"

//定时任务
@interface TimerTask : JSONObject

//原类型16bytes GUID
@property(nonatomic,strong) NSString* id;

//小时
@property(nonatomic,assign) int hour;

//分钟
@property(nonatomic,assign) int minute;

//Array[一周的某一天执行此任务，为1]
@property(nonatomic,strong) NSArray<NSNumber>* day;

//重复
@property(nonatomic,assign) BOOL repeated;

//是否启用
@property(nonatomic,assign) BOOL enabled;

//0, 1, 2 … (0：原有周重复方式，1: 小时，2：天，3：周，4：月，5：季度，6：年，7：每月的第一周星期二)
@property(nonatomic,assign) int repeatOption;

//-1,0, 1, 2… (-1无限循环，0不循环，。。。)
@property(nonatomic,strong) NSString* repeatTime;

//0,1, 2, 3, 4(重复间隔)
@property(nonatomic,strong) NSString* repeatGap;

//1,2,3,4,5,6(日)
@property(nonatomic,strong) NSString* date;

//1,2,3,4,5,6(月份)
@property(nonatomic,strong) NSString* month;

//年
@property(nonatomic,strong) NSString* year;

//1, 2,3 (每月中第几周)
@property(nonatomic,strong) NSString* weekNumMonthly;

//1..54 (每年中的第几周)
@property(nonatomic,strong) NSString* weekNumYear;

//1-366 (每年中的第几天)
@property(nonatomic,strong) NSString* dayNumYear;

@property(nonatomic,strong) NSString* Remark1;

@property(nonatomic,strong) NSString* Remark2;

@property(nonatomic,strong) NSString* Remark3;

@property(nonatomic,strong) NSString* Remark4;

@property(nonatomic,strong) NSString* Remark5;

-(id)initWithId:(NSString*)id_ Hour:(int)hour_ Minute:(int)minute_ Day:(NSArray<NSNumber>*)day_ Repeated:(BOOL)repeated Enable:(BOOL)enabled_;

@end
