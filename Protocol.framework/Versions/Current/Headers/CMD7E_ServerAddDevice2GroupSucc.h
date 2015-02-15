//
//  CMD7E_ServerAddDevice2GroupSucc.h
//  ClientProtocol
//
//  Created by chendy on 13-12-12.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ServerCommand.h"

///服务器返回添加组设备成功
@interface CMD7E_ServerAddDevice2GroupSucc : ServerCommand

///组号
@property(nonatomic,strong) NSString<expose>* groupId;

///设备ID,长度为14，00开头为Wifi设备,否则为下挂设备
@property(nonatomic,strong) NSString<expose>* devid;

-(id)initWithGroupId:(NSString*)groupId Devid:(NSString*)devid;

@end
