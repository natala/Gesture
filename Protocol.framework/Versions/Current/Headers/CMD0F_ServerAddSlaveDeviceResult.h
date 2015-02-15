//
//  CMD0F_ServerAddSlaveDeviceResult.h
//  NewProtocol
//
//  Created by chendy on 13-9-12.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ServerCommand.h"
#import "Device.h"

///服务器返回添加2.4G设备结果
@interface CMD0F_ServerAddSlaveDeviceResult : ServerCommand

///是否成功
@property(nonatomic,assign) BOOL result;

///设备信息
@property(nonatomic,strong) Device* status;

-(id)initWithResult:(BOOL)result Status:(Device*)status;

@end
