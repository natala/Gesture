//
//  CMD76_ServerAddGroupSucc.h
//  ClientProtocol
//
//  Created by chendy on 13-12-12.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ServerCommand.h"

///服务器返回添加设备组成功成功
@interface CMD76_ServerAddGroupSucc : ServerCommand

///组号
@property(nonatomic,strong) NSString<expose>* groupId;

///组名
@property(nonatomic,strong) NSString<expose>* groupName;

-(id)initWithGroupId:(NSString*)groupId GroupName:(NSString*)groupName;

@end
