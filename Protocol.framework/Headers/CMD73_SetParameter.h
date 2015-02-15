//
//  CMD73_SetLocal.h
//  ClientProtocol
//
//  Created by chendy on 13-11-26.
//  Copyright (c) 2013年 chendy. All rights reserved.
//

#import "ClientCommand.h"

///客户端发送参数设置给服务器
@interface CMD73_SetParameter : ClientCommand

///appid
@property(nonatomic,strong) NSNumber<expose>* appid;

///语言(国际化标准，如,en:英文，ch:中文)
@property(nonatomic,strong) NSString<expose>* locale;

-(id)initWithAPPID:(int)appid Locale:(NSString*)locale;

@end
