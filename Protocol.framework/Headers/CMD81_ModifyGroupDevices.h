//
//  CMD81_ModifyGroupDevices.h
//  ClientProtocol
//
//  Created by chendy on 13-12-12.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ClientCommand.h"
#import "Device.h"

///客户端发送修改设备组下的设备信息给服务器(批量增、删、改组设备)
@interface CMD81_ModifyGroupDevices : ClientCommand

///组号
@property(nonatomic,strong)NSString<expose>* groupId;

///设备id列表
@property(nonatomic,strong)NSArray<NSString,expose>* deviceList;

-(id)initWithGroupId:(NSString*)groupId DeviceList:(NSArray*)deviceList;

@end
