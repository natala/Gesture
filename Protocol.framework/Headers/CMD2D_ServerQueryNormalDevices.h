//
//  CMD2D_ServerQueryNormalDevices.h
//  NewProtocol
//
//  Created by chendy on 13-9-14.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ServerCommand.h"

///服务器返回查询常用设备指令
@interface CMD2D_ServerQueryNormalDevices : ServerCommand

///常用设备列表
@property(nonatomic,strong) NSArray* devices;

-(id)initWithDevices:(NSArray*)devices;

@end
