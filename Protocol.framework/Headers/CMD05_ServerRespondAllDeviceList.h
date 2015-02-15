//
//  CMD05_ServerRespondAllDeviceList.h
//  NewProtocol
//
//  Created by chendy on 13-9-10.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ServerCommand.h"

///服务端返回用户的所有设备列表
@interface CMD05_ServerRespondAllDeviceList : ServerCommand

///设备列表
@property(nonatomic,strong) NSArray* deviceList;

-(id)initWithDeviceList:(NSArray*)deviceList;

@end
