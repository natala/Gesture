//
//  CMD64_ForgetPassWithVerifySetup2.h
//  ClientProtocol
//
//  Created by chendy on 13-10-8.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ClientCommand.h"

///客户端发送忘记密码的第二步给服务器(使用验证码，找回密码)
@interface CMD64_ForgetPassWithVerifySetup2 : ClientCommand

///用户名
@property(nonatomic,strong) NSString<expose>* username;

///邮箱
@property(nonatomic,strong) NSString<expose>* email;

/**
 *密码
 *密码为空时，服务器发送随机密码到邮箱，否则直接修改密码
 **/
@property(nonatomic,strong) NSString<expose>* password;

///uuid
@property(nonatomic,strong) NSString<expose>* uuid;

///验证码
@property(nonatomic,strong) NSString<expose>* code;

-(id)initWithUsername:(NSString*)username Email:(NSString*)email Pass:(NSString*)pass Uuid:(NSString*)uuid Code:(NSString*)code;

@end
