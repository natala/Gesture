//
//  CMD68_RegisterWithVerifySetup1.h
//  ClientProtocol
//
//  Created by chendy on 13-10-8.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ClientCommand.h"

///客户端发送注册用户第一步给服务器(取得注册用的验证码)
@interface CMD68_RegisterWithVerifySetup1 : ClientCommand

///用户名
@property(nonatomic,strong) NSString<expose>* username;

///邮箱
@property(nonatomic,strong) NSString<expose>* email;

-(id)initWithUsername:(NSString *)username Email:(NSString *)email;

@end
