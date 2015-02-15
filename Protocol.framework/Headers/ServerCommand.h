//
//  ServerCommand.h
//  NewProtocol
//
//  Created by chendy on 13-9-10.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "Command.h"

///服务器指令的基类，所有服务器的类都继承此类
@interface ServerCommand : Command

-(id)setProtocolVer:(Byte)protocolVer SerNum:(short)ser;

@end
