//
//  SwitchDevice.h
//  ClientProtocol
//
//  Created by chendy on 13-10-23.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "Device.h"

//设备信息（以色列Socket,下挂设备）
@interface SwitchDevice : Device

//下挂设备类型
@property(nonatomic,assign) int subType;

//电源状态,true:开,false:关
@property(nonatomic,assign) BOOL power;

//功耗
@property(nonatomic,assign) int consumption;

-(id)initWithId:(NSString*)id_ Pid:(NSString*)pid Name:(NSString*)name Place:(NSString*)place Online:(BOOL)onLine Power:(BOOL)power Consumption:(int)consumption;

@end
