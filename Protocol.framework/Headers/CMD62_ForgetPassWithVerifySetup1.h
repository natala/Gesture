//
//  CMD62_ForgetPassWithVerifySetup1.h
//  ClientProtocol
//
//  Created by chendy on 13-10-8.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ClientCommand.h"

///客户端发送忘记密码第一步给服务器(取得验证码)
@interface CMD62_ForgetPassWithVerifySetup1 : ClientCommand

//用户名
@property(nonatomic,strong) NSString<expose>* username;

//邮箱
@property(nonatomic,strong) NSString<expose>* email;

-(id)initWithUsername:(NSString*)username Email:(NSString*)email;

@end
