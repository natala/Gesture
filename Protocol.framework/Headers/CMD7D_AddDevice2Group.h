//
//  CMD7D_AddDevice2Group.h
//  ClientProtocol
//
//  Created by chendy on 13-12-12.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ClientCommand.h"

///客户端发送添加组设备给服务器(添加一个组设备)
@interface CMD7D_AddDevice2Group : ClientCommand

///组号
@property(nonatomic,strong)NSString<expose>* groupId;

///设备ID,长度为14，00开头为Wifi设备,否则为下挂设备
@property(nonatomic,strong)NSString<expose>* devid;

-(id)initWithGroupId:(NSString*)grouId Devid:(NSString*)devid;

@end
