//
//  CMD83_QueryGroupDevices.h
//  ClientProtocol
//
//  Created by chendy on 13-12-12.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ClientCommand.h"

///客户端发送取得设备组下的设备信息给服务器(查询组的所有设备信息)
@interface CMD83_QueryGroupDevices : ClientCommand

///组号
@property(nonatomic,strong) NSString<expose>* groupId;

-(id)initWithGroupId:(NSString*)groupId;

@end
