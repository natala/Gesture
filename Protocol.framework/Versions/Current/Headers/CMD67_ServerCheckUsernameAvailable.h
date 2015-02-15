//
//  CMD67_ServerCheckUsernameAvailable.h
//  ClientProtocol
//
//  Created by chendy on 13-10-8.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ServerCommand.h"

///服务器返回用户名是可用的(用户名不可用时，返回FF指令)
@interface CMD67_ServerCheckUsernameAvailable : ServerCommand

@end
