//
//  CMD02_Login.h
//  NewProtocol
//
//  Created by chendy on 13-9-10.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ClientCommand.h"

///客户端发送用户名和密码登陆信息
@interface CMD02_Login : ClientCommand

///用户名
@property(nonatomic,strong) NSString* username;

///密码
@property(nonatomic,strong) NSString* password;

///时区
@property(nonatomic,assign) int offset;

///appid
@property(nonatomic,assign) int appid;

-(id)initWithUser:(NSString*)user Pass:(NSString*)pass Offset:(int)offset appid:(int)appid;

@end
