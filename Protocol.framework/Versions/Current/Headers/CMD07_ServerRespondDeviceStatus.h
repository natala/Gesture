//
//  CMD07_ServerRespondDeviceStatus.h
//  NewProtocol
//
//  Created by chendy on 13-9-11.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ServerCommand.h"
#import "Device.h"

///服务器返回单个设备状态
@interface CMD07_ServerRespondDeviceStatus : ServerCommand

///设备信息
@property(nonatomic,strong) Device* status;

-(id)initWithStatus:(Device*)status;

@end
