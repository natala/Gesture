//
//  CMD66_CheckUsername.h
//  ClientProtocol
//
//  Created by chendy on 13-10-8.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ClientCommand.h"

///客户端发送验证用户名是否可用
@interface CMD66_CheckUsername : ClientCommand

///用户名
@property(nonatomic,strong) NSString<expose>* username;

-(id)initWithUsername:(NSString*)username;

@end
