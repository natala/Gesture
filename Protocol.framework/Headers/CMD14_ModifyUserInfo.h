//
//  CMD14_ModifyUserInfo.h
//  NewProtocol
//
//  Created by chendy on 13-9-12.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ClientCommand.h"
#import "UserInfo.h"

///客户端向服务器发送修改用户信息请求
@interface CMD14_ModifyUserInfo : ClientCommand

///用户信息
@property(nonatomic,strong) UserInfo* userInfo;

-(id)initWithUserInfo:(UserInfo*)info;

@end
