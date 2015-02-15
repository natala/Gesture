//
//  CMD17_ServerQueryUserResult.h
//  NewProtocol
//
//  Created by chendy on 13-9-12.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ServerCommand.h"
#import "UserInfo.h"

///服务器返回查询用户信息结果
@interface CMD17_ServerQueryUserResult : ServerCommand

//用户信息
@property(nonatomic,strong) UserInfo* userInfo;

-(id)initWithUserInfo:(UserInfo*)info;

@end
