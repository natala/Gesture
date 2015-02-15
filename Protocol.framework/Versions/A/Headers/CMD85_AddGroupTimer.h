//
//  CMD85_AddGroupTimer.h
//  ClientProtocol
//
//  Created by chendy on 13-12-13.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ClientCommand.h"
#import "TimerTask.h"
#import "Device.h"
#import "SNDeviceTypeObject.h"

///客户端发送添加组定时器给服务器(添加组定时器)
@interface CMD85_AddGroupTimer : ClientCommand

///组号
@property(nonatomic,strong) NSString* groupId;

///定时信息
@property(nonatomic,strong) TimerTask* schedinfo;

///设备信息
@property(nonatomic,strong) Device* ctrlinfo;

/**
 * 控制类型<br>
 * 0、全控，1、控制MAC，2、控制SN
 *
 */
@property(nonatomic,assign) int controlType;

/**
 * WIFI设备的设备类型列表，用来指定当controlType为1时，群控哪些wifi设备<br>
 * controlType为0时，可不设此值
 */
@property(nonatomic,strong) NSArray<NSNumber>* deviceTypeList;

/**
 * 下挂设备类型列表，来确定当controlType为2时，群控哪些下挂设备<br>
 * controlType为0时，可不设此值
 */
@property(nonatomic,strong) NSArray<SNDeviceTypeObject>* snTypeList;

-(id)initWithGroupId:(NSString*)groupId Schedinfo:(TimerTask*)schedinfo Ctrlinfo:(Device*)ctrlinfo ControlType:(int)controlType DeivceTypeList:(NSArray*)deviceTypeList SnTypeList:(NSArray*)snTypeList;

@end
