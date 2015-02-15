//
//  CMD52_ServerJump.h
//  NewProtocol
//
//  Created by chendy on 13-9-14.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ServerCommand.h"

///服务器发送跳转指令客户端
@interface CMD52_ServerJump : ServerCommand

///跳转到的服务器的地址
@property(nonatomic,strong) NSString* ip;

///跳转到的服务器的端口
@property(nonatomic,assign) int port;

-(id)initWithIp:(NSString*)ip Port:(int)port;

@end
