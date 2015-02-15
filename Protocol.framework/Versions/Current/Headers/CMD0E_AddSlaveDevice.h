//
//  CMD0E_AddSlaveDevice.h
//  NewProtocol
//
//  Created by chendy on 13-9-11.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ClientCommand.h"

///客户端发送添加2.4G设备信息指令
@interface CMD0E_AddSlaveDevice : ClientCommand

///密码
@property(nonatomic,strong) NSString* password;

///SN号
@property(nonatomic,strong) NSString* sn;

///PID
@property(nonatomic,strong) NSString* pid;

///设备名称
@property(nonatomic,strong) NSString* name;

///设备摆放的位置
@property(nonatomic,strong) NSString* place;

-(id)initWithPass:(NSString*)pass SN:(NSString*)sn Pid:(NSString*)pid Name:(NSString*)name Place:(NSString*)place;

@end
