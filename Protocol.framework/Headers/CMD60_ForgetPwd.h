//
//  CMD60_ForgetPwd.h
//  ClientProtocol
//
//  Created by chendy on 13-9-20.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ClientCommand.h"

///忘记密码
@interface CMD60_ForgetPwd : ClientCommand

///用户名
@property(nonatomic,strong) NSString* username;

///邮箱
@property(nonatomic,strong) NSString* email;

-(id)initWithUsername:(NSString*)username Email:(NSString*)email;

@end
