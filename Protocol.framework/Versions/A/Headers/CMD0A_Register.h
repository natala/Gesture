//
//  CMD0A_Register.h
//  NewProtocol
//
//  Created by chendy on 13-9-11.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ClientCommand.h"

///客户端向服务器发送用户注册请求
@interface CMD0A_Register : ClientCommand

///用户名
@property(nonatomic,strong) NSString* username;

///密码
@property(nonatomic,strong) NSString* password;

///电话
@property(nonatomic,strong) NSString* phone;

///邮件地址
@property(nonatomic,strong) NSString* email;


-(id)initWithUser:(NSString*) username Pass:(NSString*)password Phone:(NSString*)phone Email:(NSString*)email;

@end
