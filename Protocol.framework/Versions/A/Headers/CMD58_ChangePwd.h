//
//  CMD58_ChangePwd.h
//  ClientProtocol
//
//  Created by chendy on 13-9-18.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ClientCommand.h"

///修改密码
@interface CMD58_ChangePwd : ClientCommand

///用户名
@property(nonatomic,strong) NSString* username;

///新密码
@property(nonatomic,strong) NSString* pass;

///旧密码
@property(nonatomic,strong) NSString* oldPassword;

-(id)initWithUsername:(NSString*)username OldPass:(NSString*)oldPassword NewPass:(NSString*)newPassword;

@end
