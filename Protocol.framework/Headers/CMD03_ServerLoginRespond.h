//
//  CMD03_ServerLoginRespond.h
//  NewProtocol
//
//  Created by chendy on 13-9-10.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ServerCommand.h"
#import "UserInfo.h"

///服务器指示是否用户登陆成功
@interface CMD03_ServerLoginRespond : ServerCommand

///是否成功
@property(nonatomic,assign) BOOL result;

///用户信息
@property(nonatomic,strong) UserInfo* info;

-(id)initWithResult:(BOOL)result Info:(UserInfo*)info;

@end
