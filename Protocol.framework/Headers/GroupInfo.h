//
//  CMD7C_Object.h
//  ClientProtocol
//
//  Created by chendy on 13-12-12.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "JSONObject.h"
#import "Device.h"
#import "TimerInfo.h"

///设备组的所有信息(组信息、组设备信息及组的定时器信息)
@interface GroupInfo : JSONObject

///组号
@property(nonatomic,strong) NSString* groupId;

///组名
@property(nonatomic,strong) NSString* groupName;

///设备列表
@property(nonatomic,strong) NSArray<Device>* deviceList;

///定时任务列表
@property(nonatomic,strong) NSArray<TimerInfo>* timerList;

-(id)initWithGroupId:(NSString*)groupId GroupName:(NSString*)groupName DeivceList:(NSArray*)deviceList TimerList:(NSArray*)timerList;

@end
