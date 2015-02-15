//
//  CMD82_ServerModifyGroupDevicesSucc.h
//  ClientProtocol
//
//  Created by chendy on 13-12-12.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ServerCommand.h"

///服务器返回修改设备组下的设备信息成功(批量增、删、改组设备)
@interface CMD82_ServerModifyGroupDevicesSucc : ServerCommand

///组号
@property(nonatomic,strong)NSString<expose>* groupId;

///组号
@property(nonatomic,strong)NSArray<NSString,expose>* deviceList;

-(id)initWithGroupId:(NSString*)groupId DeviceList:(NSArray*)deviceList;

@end
