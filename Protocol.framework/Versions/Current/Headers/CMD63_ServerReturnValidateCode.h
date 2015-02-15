//
//  CMD63_ServerReturnValidateCode.h
//  ClientProtocol
//
//  Created by chendy on 13-10-8.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ServerCommand.h"

///服务器返回uuid(验证码发到用户邮箱)
@interface CMD63_ServerReturnValidateCode : ServerCommand

///uuid
@property(nonatomic,strong) NSString<expose>* uuid;

-(id)initWithUUID:(NSString*)uuid;

@end
