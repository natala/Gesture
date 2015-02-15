//
//  CMD26_AddNormalDevice.h
//  NewProtocol
//
//  Created by chendy on 13-9-13.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ClientCommand.h"
#import "NormalDevice.h"

///客户端发送添加单个常用设备指令
@interface CMD26_AddNormalDevice : ClientCommand

///常用设备信息
@property(nonatomic,strong) NormalDevice* info;

-(id)initWithInfo:(NormalDevice*)info;

@end
