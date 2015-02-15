//
//  LEDDeviceStatus.h
//  NewProtocol
//
//  Created by chendy on 13-9-9.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "Device.h"
#import "Power.h"

//带调光灯开关的设备信息
@interface LEDDeviceStatus : Device

//电源状态,多路
@property(nonatomic,strong) NSArray<Power,ConvertOnDemand>* power;

//灯的亮度
@property(nonatomic,assign) int bright;

-(id)initWithId:(NSString*)id_ Pid:(NSString*)pid Name:(NSString*)name Place:(NSString*)place Online:(BOOL)onLine Power:(NSArray*)powers Bright:(int)bright;

@end
