//
//  DeviceTypeConst.h
//  ClientProtocol
//
//  Created by chendy on 13-10-23.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    //插座、墙壁开关、灯开关等常规开关的类型
    TYPE_DEVICE = 0,
    //带调光灯开关的类型
    TYPE_LED_DEVICE = 4,
    //空调类型
    TYPE_AIRCONDITION = 5,
    //诺德类型
    TYPE_NUODE = 20,
    //红外学习设备
    TYPE_IR = 21,
    //设备类型为电风扇
    TYPE_FAN = 22,
    //以色列设备
    TYPE_YSL = 23,
}DeviceType;

typedef enum {
    //以色列的下挂设备的Socket设备
    SUB_TYPE_SOCKET = 1,
    //以色列的下挂设备的Switch设备
    SUB_TYPE_SWITCH = 2,
}SubDeviceType;

@interface DeviceTypeConst : NSObject

@end
