//
//  CMD75_AddGroup.h
//  ClientProtocol
//
//  Created by chendy on 13-12-12.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ClientCommand.h"

///客户端发送添加设备组给服务器(添加组)
@interface CMD75_AddGroup : ClientCommand

///组名
@property(nonatomic,strong) NSString<expose>* groupName;

-(id)initWithGroupName:(NSString*)groupName;

@end
