//
//  CMD6A_RegisterWithVerifySetup2.h
//  ClientProtocol
//
//  Created by chendy on 13-10-8.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ClientCommand.h"

///客户端发送注册第二步给服务器(发送注册信息)
@interface CMD6A_RegisterWithVerifySetup2 : ClientCommand

///用户名
@property(nonatomic,strong) NSString<expose>* username;

///密码
@property(nonatomic,strong) NSString<expose>* password;

///电话
@property(nonatomic,strong) NSString<expose>* phone;

///邮件地址
@property(nonatomic,strong) NSString<expose>* email;

///uuid
@property(nonatomic,strong) NSString<expose>* uuid;

///验证码
@property(nonatomic,strong) NSString<expose>* code;

-(id)initWithUsername:(NSString*)username Pass:(NSString*)pass Phone:(NSString*)phone Email:(NSString*)email UUID:(NSString*)uuid Code:(NSString*)code;

@end
