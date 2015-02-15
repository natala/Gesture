//
//  NuodeDeviceStatus.h
//  ClientProtocol
//
//  Created by chendy on 13-10-15.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "JSONObject.h"
#import "Status.h"

//诺德设备的状态类包含下挂信息
@interface NuodeDeviceStatus : JSONObject

//日期
@property(nonatomic,strong) NSString* date;

//下挂设备状态列表
@property(nonatomic,strong) NSArray<Status>* list;

-(id)initWithDate:(NSString*)date List:(NSArray*)list;

@end
