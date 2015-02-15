//
//  CMD55_ServerControlResult.h
//  NewProtocol
//
//  Created by chendy on 13-9-14.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ServerCommand.h"

///服务器发送控制结果,兼容其他的协议
@interface CMD55_ServerControlResult : ServerCommand

///MAC地址
@property(nonatomic,strong) NSString<expose>* mac;

///SN号
@property(nonatomic,strong) NSString<expose>* sn;

///16进制的原格式字符串
@property(nonatomic,strong) NSString<expose>* hexstr;

-(id)initWithMac:(NSString*)mac SN:(NSString*)sn Hexstr:(NSString*)hexstr;


@end
