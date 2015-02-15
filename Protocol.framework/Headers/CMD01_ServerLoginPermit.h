//
//  CMD01_ServerLoginPermit.h
//  NewProtocol
//
//  Created by chendy on 13-9-10.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ServerCommand.h"

///服务器发送登录许可
@interface CMD01_ServerLoginPermit : ServerCommand

///登录密钥
@property(nonatomic,strong) NSString* key;

-(id)initWithKey:(NSString*)key;

@end
