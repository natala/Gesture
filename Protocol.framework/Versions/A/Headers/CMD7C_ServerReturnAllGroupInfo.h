//
//  CMD7C_ServerReturnAllGroupInfo.h
//  ClientProtocol
//
//  Created by chendy on 13-12-12.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ServerCommand.h"

///服务器返回所有设备组的所有信息(组信息、组设备信息及组的定时器信息)
@interface CMD7C_ServerReturnAllGroupInfo : ServerCommand

///所有组的所有信息(GroupInfo的列表)
@property(nonatomic,strong) NSArray* groupInfoList;

-(id)initWithGroupInfo:(NSArray*)groupInfoList;

@end
