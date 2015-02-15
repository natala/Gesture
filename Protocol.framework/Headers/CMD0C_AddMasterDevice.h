//
//  CMD0C_AddMasterDevice.h
//  NewProtocol
//
//  Created by chendy on 13-9-11.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ClientCommand.h"

///客户端发送添加WiFi设备信息指令
@interface CMD0C_AddMasterDevice : ClientCommand

///密码
@property(nonatomic,strong) NSString* password;

///MAC
@property(nonatomic,strong) NSString* MAC;

///设备名称
@property(nonatomic,strong) NSString* name;

///设备摆放位置
@property(nonatomic,strong) NSString* place;

-(id)initWithPass:(NSString*)pass MAC:(NSString*)mac Name:(NSString*)name Place:(NSString*)place;

@end
