//
//  DeviceStatus.h
//  NewProtocol
//
//  Created by chendy on 13-9-5.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

//设备信息（插座，墙壁开关，灯开关），其他设备信息继承此类
#import <Foundation/Foundation.h>
#import "Power.h"
#import "JSONObject.h"
#import "Device.h"

@interface DeviceStatus : Device

-(id)initWithId:(NSString*)id_ Pid:(NSString*)pid Name:(NSString*)name Place:(NSString*)place Online:(BOOL)onLine Power:(NSArray*)powers;

//电源状态,多路
@property(nonatomic,strong) NSArray<Power,ConvertOnDemand>* power;

//设置第一路开关的状态
-(void)setOneWayPower:(BOOL)on;

//获得第一路开关的状态
-(BOOL)getOneWayPower;

@end
