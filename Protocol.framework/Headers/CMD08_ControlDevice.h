//
//  CMD08_ControlDevice.h
//  NewProtocol
//
//  Created by chendy on 13-9-11.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ClientCommand.h"
#import "Device.h"

///客户端发送对某个设备信息指令
@interface CMD08_ControlDevice : ClientCommand


///设备信息
@property(nonatomic,strong) Device* status;

-(id)initWithStatus:(Device*)status;

@end
