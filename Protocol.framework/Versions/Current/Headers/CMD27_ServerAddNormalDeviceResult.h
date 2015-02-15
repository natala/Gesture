//
//  CMD27_ServerAddNormalDeviceResult.h
//  NewProtocol
//
//  Created by chendy on 13-9-13.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ServerCommand.h"
#import "NormalDevice.h"

///服务器返回添加常用设备结果
@interface CMD27_ServerAddNormalDeviceResult : ServerCommand

///是否成功
@property(nonatomic,assign) BOOL result;

///常用设备信息
@property(nonatomic,strong) NormalDevice* device;

-(id)initWithResult:(BOOL)result Device:(NormalDevice*)device;

@end
