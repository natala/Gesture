//
//  CMD8E_ServerControlGroupDeviceSucc.h
//  ClientProtocol
//
//  Created by chendy on 13-12-13.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ServerCommand.h"
#import "Device.h"

///服务器返回控制组设备成功
@interface CMD8E_ServerControlGroupDeviceSucc : ServerCommand

///组号
@property(nonatomic,strong) NSString<expose>* groupId;

///设备信息
@property(nonatomic,strong) Device* ctrlinfo;

-(id)initWithGroupId:(NSString*)groupId Ctrlinfo:(Device*)ctrlinfo;

@end
