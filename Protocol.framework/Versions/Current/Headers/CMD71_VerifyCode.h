//
//  CMD71_VerifyCode.h
//  ClientProtocol
//
//  Created by chendy on 13-10-30.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ClientCommand.h"

///客户端发送验证码给服务器
@interface CMD71_VerifyCode : ClientCommand

///uuid
@property(nonatomic,strong) NSString<expose>* uuid;

///验证码
@property(nonatomic,strong) NSString<expose>* code;

-(id)initWithUUID:(NSString*)uuid Code:(NSString*)code;

@end
