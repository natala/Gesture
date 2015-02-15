//
//  CMD84_ServerRetrunGroupDevices.h
//  ClientProtocol
//
//  Created by chendy on 13-12-12.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ServerCommand.h"

///服务器返回设备组的所有设备信息(组的所有设备信息)
@interface CMD84_ServerRetrunGroupDevices : ServerCommand

///组号
@property(nonatomic,strong) NSString* groupId;

///设备列表(Device子类的列表)
@property(nonatomic,strong) NSArray* deviceList;

-(id)initWithGroupId:(NSString*)groupId DeviceList:(NSArray*)deviceList;

@end
